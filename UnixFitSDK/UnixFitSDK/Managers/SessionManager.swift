//
//  SessionManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

public protocol SessionManaging: AnyObject {
    var peripheralModel: PeripheralModel { get }
    var currentTrainingStatus: TrainingStatusData? { get }
    var currentDeviceData: DeviceData? { get }

    func addDelegate(_ delegate: SessionManagerDelegate)
    func removeDelegate(_ delegate: SessionManagerDelegate)
    func send(commandWithValue: CommandWithValue)
}

class SessionManager: NSObject, SessionManaging {
    // MARK: - Public properties
    public let peripheralModel: PeripheralModel

    public var currentTrainingStatus: TrainingStatusData?
    public var currentDeviceData: DeviceData?
    public var currentFtmsFeaturesData: FTMSFeaturesData?

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
        multicastDelegate.invoke { $0.sessionManagerDidFetchDeviceData(deviceData) }
    }

    func sendTrainingStatus(_ status: TrainingStatusData) {
        currentTrainingStatus = status
        multicastDelegate.invoke { $0.sessionManagerDidChangeTrainingStatus(status) }
    }

    func sendCommandResponse(_ response: CommandResponseData) {
        multicastDelegate.invoke { $0.sessionManagerDidCompleteCommand(commandResponse: response) }
    }

    func fetch(ftmsFeaturesData: FTMSFeaturesData) {
        currentFtmsFeaturesData =  ftmsFeaturesData
        multicastDelegate.invoke { $0.sessionManagerDidFetchFTMSFeatures(ftmsFeaturesData)}
    }

    func sendFTMSStatus(_ status: FTMSStatus) {
        multicastDelegate.invoke { $0.sessionManagerDidRecieveFTMSStatus(status)}
    }
}
