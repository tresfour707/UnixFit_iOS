//
//  BluetoothManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

/// Интерфейс для работы с ``BluetoothManager``.
public protocol BluetoothManaging: AnyObject {
    /// Флаг, сигнализирущий о том, что менеджер готов к поиску устройств и взаимодействию с ними.
    var isReady: Bool { get }

    /// Флаг, сигнализирующий о том, идет ли в данный момент поиск устройств.
    var isScanning: Bool { get }

    /// Массив со структурами найденных устройств.
    var peripheralModels: [PeripheralModel] { get }

    /// Объект менеджера для работы с подключенным устройством. Имеет значение nil, если в данный момент устройство не подключено.
    /// Создается автоматически при подключении устройства. Шарится между разными экземплярами ``BluetoothManager``
    var activeSessionManager: SessionManaging? { get }

    /// Очередь, на которой вызываются методы делегата ``BluetoothManagerDelegate``. По дефолту используется DispatchQueue.main
    var outputQueue: DispatchQueue { get set }

    /// Метод для поиска новых устройств. Поиск идет до тех пор, пока не остановить его вручную
    func scanForPeripherals()

    /// Метод для остановки поиска
    func stopScanningForPeripherals()

    /// Метод для коннекта устройства при помощи модели ``PeripheralModel``
    func connect(to peripheralModel: PeripheralModel)

    /// Метод для коннекта устройства при помощи id
    func connectToPeripheral(with id: UUID)

    /// Метод для дисконнекта  устройства
    func disconnect(peripheralModel: PeripheralModel)
    
    /// Метод для удаления сохраненных структур устройств
    func deleteStoredPeripherals()
}

/// Класс BluetoothManager предназначен для поиска, подключения/отключения устройств с FTMS, а так же хранит в себе структуры найденных устройств
public class BluetoothManager: NSObject, BluetoothManaging {
    // MARK: - Public properties
    /// Флаг, сигнализирущий о том, что менеджер готов к поиску устройств и взаимодействию с ними
    public var isReady: Bool = false {
        didSet {
            outputQueue.async { [weak self] in
                guard let self else {
                    return
                }
                self.bluetoothManagerDelegate?.bluetoothManagerDidReadyStateSwitched(self.isReady)
            }
        }
    }

    /// Флаг, сигнализирующий о том, идет ли в данный момент поиск устройств
    public var isScanning: Bool {
        centralManager.isScanning
    }

    /// Массив со структурами  найденных устройств
    public var peripheralModels: [PeripheralModel] {
        peripheralsDictionary.values.sorted { $0.id > $1.id }
    }

    /// Объект менеджера для работы с подключенным устройством. Имеет значение nil, если в данный момент устройство не подключено.
    /// Создается автоматически при подключении устройства. Шарится между разными экземплярами BluetoothManager
    public var activeSessionManager: SessionManaging? {
        get {
            BluetoothManager.currentSessionManager
        }
        set {
            BluetoothManager.currentSessionManager = newValue
        }
    }

    /// Очередь, на которой вызываются методы делегата BluetoothManagerDelegate. По умолчанию используется DispatchQueue.main
    public var outputQueue: DispatchQueue = .main

    // MARK: - Internal properties
    weak var bluetoothManagerDelegate: BluetoothManagerDelegate?

    // MARK: - Private properties
    private let centralManagerQueue = DispatchQueue(
        label: "com.unitfitsdk.bluetooth.central",
        attributes: DispatchQueue.Attributes.concurrent
    )
    private var centralManager: CBCentralManager!

    private var peripheralsDictionary: [UUID: PeripheralModel] = [:]
    private static var currentSessionManager: SessionManaging?

    // MARK: - Initialization
    /// Инициализатор. Для инициализации требуется прокинуть делегат BluetoothManagerDelegate для получения обратной связи от менеджера
    public init(delegate: BluetoothManagerDelegate) {
        bluetoothManagerDelegate = delegate
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: centralManagerQueue)
        isReady = centralManager.state == CBManagerState.poweredOn
    }

    // MARK: - Deinitialization
    deinit {
        centralManager.stopScan()
    }

    // MARK: - Public methods
    /// Метод для коннекта устройства при помощи модели PeripheralModel
    public func connect(to peripheralModel: PeripheralModel) {
        centralManager.connect(peripheralModel.peripheral)
    }

    /// Метод для коннекта устройства при помощи id
    public func connectToPeripheral(with id: UUID) {
        guard let peripheral = peripheralModel(with: id) else {
            return
        }

        connect(to: peripheral)
    }

    /// Метод для дисконнекта  устройства
    public func disconnect(peripheralModel: PeripheralModel) {
        centralManager.cancelPeripheralConnection(peripheralModel.peripheral)
    }

    /// Метод для поиска новых устройств. Поиск идет до тех пор, пока не остановить его вручную
    public func scanForPeripherals() {
        centralManager.scanForPeripherals(withServices: [FTMSCharacteristic.serviceFTMS.uuid], options: nil)
    }

    /// Метод для остановки поиска
    public func stopScanningForPeripherals() {
        centralManager.stopScan()
    }

    /// Метод для удаления сохраненных структур устройств
    public func deleteStoredPeripherals() {
        peripheralsDictionary = [:]
    }

    // MARK: - Internal methods
    func savePeripheral(_ peripheral: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber) {
        let peripheralModel = PeripheralModel(
            peripheral: peripheral,
            advertisementData: advertisementData,
            rssi: rssi
        )
        peripheralsDictionary[peripheral.identifier] = peripheralModel
        outputQueue.async { [weak self] in
            self?.bluetoothManagerDelegate?.bluetoothManagerDidDiscover(peripheralModel: peripheralModel)
        }
    }

    func createSessionManager(for peripheral: CBPeripheral) {
        guard let peripheralModel = peripheralsDictionary[peripheral.identifier] else {
            return
        }

        activeSessionManager = SessionManager(peripheralModel: peripheralModel)
        activeSessionManager?.outputQueue = outputQueue
        outputQueue.async { [weak self] in
            self?.bluetoothManagerDelegate?.bluetoothManagerDidConnectToPeripheral(with: peripheralModel)
        }
    }

    func removeSessionManager() {
        activeSessionManager = nil
    }

    func peripheralModel(with id: UUID) -> PeripheralModel? {
        peripheralsDictionary[id]
    }

    func didRecieveFailedState(with error: BluetoothError) {
        outputQueue.async { [weak self] in
            self?.bluetoothManagerDelegate?.bluetoothManagerDidFail(with: error)
        }
    }
}
