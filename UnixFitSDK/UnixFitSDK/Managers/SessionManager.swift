//
//  SessionManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

/// Интерфейс для работы с подключенным тренажером.
public protocol SessionManaging: AnyObject {
    /// Структура подключенного устройства.
    var peripheralModel: PeripheralModel { get }

    /// Текущий статус тренировки.
    var currentTrainingStatus: TrainingStatusData? { get }

    /// Текущие данные устройства.
    var currentDeviceData: DeviceData? { get }

    /// Очередь, на которой вызываются методы делегата ``SessionManagerDelegate``. По умолчанию используется очередь из родительского ``BluetoothManager``
    var outputQueue: DispatchQueue { get set }

    /// Функция добавляет делегат в пул для получения обратной связи от менеджера
    func addDelegate(_ delegate: SessionManagerDelegate)

    /// Функция удаляет делегат из пула
    func removeDelegate(_ delegate: SessionManagerDelegate)

    /// Функция для отправки команды в тренажер
    func send(commandWithValue: CommandWithValue)
}

class SessionManager: NSObject, SessionManaging {
    // MARK: - Public properties
    public let peripheralModel: PeripheralModel

    public var currentTrainingStatus: TrainingStatusData?
    public var currentDeviceData: DeviceData?
    public var currentFtmsFeaturesData: FTMSFeaturesData?

    public var currentSupportedSpeedRange: SupportedSpeedRange?
    public var currentSupportedInclinationRange: SupportedInclinationRange?
    public var currentSupportedResistanceLevelRange: SupportedResistanceLevelRange?
    public var currentSupportedPowerRange: SupportedPowerRange?
    public var currentSupportedHeartRateRange: SupportedHeartRateRange?

    public var outputQueue: DispatchQueue = .main

    // MARK: - Fileprivate properties
    fileprivate var controlCharacteristic: CBCharacteristic?
    fileprivate var multicastDelegate = MulticastDelegate<SessionManagerDelegate>()

    // MARK: - Initialization
    init(peripheralModel: PeripheralModel) {
        self.peripheralModel = peripheralModel
        super.init()
        peripheralModel.peripheral.delegate = self
        peripheralModel.peripheral.discoverServices([FTMSCharacteristic.serviceFTMS.uuid])
    }

    // MARK: - Public methods
    public func addDelegate(_ delegate: SessionManagerDelegate) {
        multicastDelegate.add(delegate: delegate)
    }

    public func removeDelegate(_ delegate: SessionManagerDelegate) {
        multicastDelegate.remove(delegate: delegate)
    }

    public func send(commandWithValue: CommandWithValue) {
        guard let controlCharacteristic else {
            return
        }
        let command = commandWithValue.createCommand()
        peripheralModel.peripheral.writeValue(command.data, for: controlCharacteristic, type: .withResponse)
    }

    // MARK: - Internal methods
    func save(controlCharacteristic: CBCharacteristic) {
        self.controlCharacteristic = controlCharacteristic
    }

    func fetch(deviceData: DeviceData) {
        currentDeviceData = deviceData
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidFetchDeviceData(deviceData) }
        }
    }

    func sendTrainingStatus(_ status: TrainingStatusData) {
        currentTrainingStatus = status
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidChangeTrainingStatus(status) }
        }
    }

    func sendCommandResponse(_ response: CommandResponseData) {
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidCompleteCommand(commandResponse: response) }
        }
    }

    func fetch(ftmsFeaturesData: FTMSFeaturesData) {
        currentFtmsFeaturesData =  ftmsFeaturesData
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidFetchFTMSFeatures(ftmsFeaturesData)}
        }
    }

    func sendFTMSStatus(_ status: FTMSStatus) {
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidRecieveFTMSStatus(status)}
        }
    }

    func sendSupportedSpeedRange(_ range: SupportedSpeedRange) {
        currentSupportedSpeedRange = range
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidRecieveSupportedSpeedRange(range)}
        }
    }

    func sendSupportedPowerRange(_ range: SupportedPowerRange) {
        currentSupportedPowerRange = range
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidRecieveSupportedPowerRange(range)}
        }
    }

    func sendSupportedInclinationRange(_ range: SupportedInclinationRange) {
        currentSupportedInclinationRange = range
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidRecieveSupportedInclinationRange(range)}
        }
    }

    func sendSupportedResistanceLevelRange(_ range: SupportedResistanceLevelRange) {
        currentSupportedResistanceLevelRange = range
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidRecieveSupportedResistanceLevelRange(range)}
        }
    }

    func sendSupportedHeartRateRange(_ range: SupportedHeartRateRange) {
        currentSupportedHeartRateRange = range
        outputQueue.async { [weak self] in
            self?.multicastDelegate.invoke { $0.sessionManagerDidRecieveSupportedHeartRateRange(range)}
        }
    }
}
