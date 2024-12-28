//
//  BluetoothManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

class BluetoothManager: NSObject {
    static let shared = BluetoothManager()

    var isReady: Bool = false {
        didSet {
            tryToScanForFTMS()
        }
    }

    var peripherals = Set<CBPeripheral>()

    private let centralManagerQueue = DispatchQueue(
        label: "com.unitfitsdk.bluetooth.central",
        attributes: DispatchQueue.Attributes.concurrent
    )
    private var centralManager: CBCentralManager!

    override private init( ) {
        super.init()

        centralManager = CBCentralManager(delegate: self, queue: centralManagerQueue)
        isReady = centralManager.state == CBManagerState.poweredOn
    }

    // MARK: - Public methods
    public func setDelegate(_ delegate: BluetoothManagerDelegate) {
        
    }

    // MARK: - Internal methods
    func tryToScanForFTMS() {
        if isReady {
            scanForFTMS()
        } else {
            stopScanningForFTMS()
        }
    }

    func scanForFTMS() {
        centralManager.scanForPeripherals(withServices: [FTMSCharacteristic.serviceFTMS.uuid], options: nil)
    }

    func stopScanningForFTMS() {
        centralManager.stopScan()
    }

    func savePeripheral(_ peripheral: CBPeripheral) {
        peripherals.insert(peripheral)
    }
}
