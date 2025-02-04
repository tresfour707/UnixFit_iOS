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
            didRecieveFailedState(with: .unknown)

        case .resetting:
            didRecieveFailedState(with: .resetting)

        case .unsupported:
            didRecieveFailedState(with: .unsupported)

        case .unauthorized:
            didRecieveFailedState(with: .unauthorized)

        case .poweredOff:
            break

        case .poweredOn:
            break

        @unknown default:
            didRecieveFailedState(with: .unknown)
        }

        isReady = central.state == .poweredOn
    }

    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        createSessionManager(for: peripheral)
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        savePeripheral(peripheral, advertisementData: advertisementData, rssi: RSSI)
    }

    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        removeSessionManager()
        guard let peripheralModel = peripheralModel(with: peripheral.identifier) else {
            return
        }
        outputQueue.async { [weak self] in
            self?.bluetoothManagerDelegate?.bluetoothManagerDidDisconnectPeripheral(peripheralModel)
        }
    }

    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        guard let peripheralModel = peripheralModel(with: peripheral.identifier) else {
            return
        }
        outputQueue.async { [weak self] in
            self?.bluetoothManagerDelegate?.bluetoothManagerDidFailToConnectPeripheral(peripheralModel, error: error)
        }
    }
}
