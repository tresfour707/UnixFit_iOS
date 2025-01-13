//
//  BluetoothManager+CBCentralManagerDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

extension BluetoothManager: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("[BluetoothManager] state: unknown")
            bluetoothManagerDelegate?.bluetoothManagerDidFail(with: .unknown)

        case .resetting:
            print("[BluetoothManager] state: resetting")
            bluetoothManagerDelegate?.bluetoothManagerDidFail(with: .resetting)

        case .unsupported:
            print("[BluetoothManager] state: not available")
            bluetoothManagerDelegate?.bluetoothManagerDidFail(with: .unsupported)

        case .unauthorized:
            print("[BluetoothManager] state: not authorized")
            bluetoothManagerDelegate?.bluetoothManagerDidFail(with: .unauthorized)

        case .poweredOff:
            print("[BluetoothManager] state: powered off")

        case .poweredOn:
            print("[BluetoothManager] state: powered on")

        @unknown default:
            print("[BluetoothManager] state: unknown")
            bluetoothManagerDelegate?.bluetoothManagerDidFail(with: .unknown)
        }

        isReady = central.state == .poweredOn
    }

    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("[BluetoothManager] did connect:", peripheral.name ?? "")
        createSessionManager(for: peripheral)
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("[BluetoothManager] did discover:", peripheral)
        savePeripheral(peripheral, advertisementData: advertisementData, rssi: RSSI)
    }

    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("[BluetoothManager] did disconnect:", peripheral.name ?? "")
        removeSessionManager()
        guard let peripheralModel = peripheralModel(with: peripheral.identifier) else {
            return
        }
        bluetoothManagerDelegate?.bluetoothManagerDidDisconnectPeripheral(peripheralModel)
    }

    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("[BluetoothManager] did fail to connect:", peripheral.name ?? "")
        guard let peripheralModel = peripheralModel(with: peripheral.identifier) else {
            return
        }
        bluetoothManagerDelegate?.bluetoothManagerDidFailToConnectPeripheral(peripheralModel, error: error)
    }
}
