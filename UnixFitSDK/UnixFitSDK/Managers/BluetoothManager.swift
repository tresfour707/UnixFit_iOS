//
//  BluetoothManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

public protocol BluetoothManaging: AnyObject {
    var isReady: Bool { get }
    var isScanning: Bool { get }
    var peripheralModels: [PeripheralModel] { get }
    var activeSessionManager: SessionManaging? { get }

    func scanForPeripherals()
    func stopScanningForPeripherals()

    func connect(to peripheralModel: PeripheralModel)
    func connectToPeripheral(with id: UUID)
    func disconnect(peripheralModel: PeripheralModel)

    func deleteStoredPeripherals()
}

public class BluetoothManager: NSObject, BluetoothManaging {
    // MARK: - Public properties
    public var isReady: Bool = false {
        didSet {
            bluetoothManagerDelegate?.bluetoothManagerDidReadyStateSwitched(isReady)
        }
    }

    public var isScanning: Bool {
        centralManager.isScanning
    }

    public var peripheralModels: [PeripheralModel] {
        peripheralsDictionary.values.sorted { $0.id > $1.id }
    }

    public var activeSessionManager: SessionManaging? {
        get {
            BluetoothManager.currentSessionManager
        }
        set {
            BluetoothManager.currentSessionManager = newValue
        }
    }

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
    public func connect(to peripheralModel: PeripheralModel) {
        centralManager.connect(peripheralModel.peripheral)
    }

    public func disconnect(peripheralModel: PeripheralModel) {
        centralManager.cancelPeripheralConnection(peripheralModel.peripheral)
    }

    public func connectToPeripheral(with id: UUID) {
        guard let peripheral = peripheralModel(with: id) else {
            return
        }

        connect(to: peripheral)
    }

    public func scanForPeripherals() {
        centralManager.scanForPeripherals(withServices: [FTMSCharacteristic.serviceFTMS.uuid], options: nil)
    }

    public func stopScanningForPeripherals() {
        centralManager.stopScan()
    }

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
        bluetoothManagerDelegate?.bluetoothManagerDidDiscover(peripheralModel: peripheralModel)
    }

    func createSessionManager(for peripheral: CBPeripheral) {
        guard let peripheralModel = peripheralsDictionary[peripheral.identifier] else {
            return
        }

        activeSessionManager = SessionManager(peripheralModel: peripheralModel)
        bluetoothManagerDelegate?.bluetoothManagerDidConnectToPeripheral(with: peripheralModel)
    }

    func removeSessionManager() {
        activeSessionManager = nil
    }

    func peripheralModel(with id: UUID) -> PeripheralModel? {
        peripheralsDictionary[id]
    }
}
