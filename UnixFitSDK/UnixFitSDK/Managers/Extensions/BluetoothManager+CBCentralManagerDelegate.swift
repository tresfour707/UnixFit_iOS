//
//  BluetoothManager+CBCentralManagerDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("[BluetoothManager] state: unknown")

        case .resetting:
            print("[BluetoothManager] state: resetting")

        case .unsupported:
            print("[BluetoothManager] state: not available")

        case .unauthorized:
            print("[BluetoothManager] state: not authorized")

        case .poweredOff:
            print("[BluetoothManager] state: powered off")
            stopScanningForFTMS()

        case .poweredOn:
            print("[BluetoothManager] state: powered on")

        @unknown default:
            print("[BluetoothManager] state: unknown")
        }

        isReady = central.state == .poweredOn
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        print("[BluetoothManager] did connect:", peripheral.name ?? "")
        peripheral.discoverServices([FTMSCharacteristic.serviceFTMS.uuid])
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print("[BluetoothManager] did discover:", peripheral)
        savePeripheral(peripheral)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {

        print("[BluetoothManager] did disconnect:", peripheral.name ?? "")
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {

        print("[BluetoothManager] did fail to connect:", peripheral.name ?? "")
    }
}
