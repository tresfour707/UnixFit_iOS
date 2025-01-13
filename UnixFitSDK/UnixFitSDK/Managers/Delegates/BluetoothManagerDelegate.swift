//
//  BluetoothManagerDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 28.12.2024.
//

import Foundation

public protocol BluetoothManagerDelegate: AnyObject {
    func bluetoothManagerDidFail(with error: BluetoothError)
    func bluetoothManagerDidReadyStateSwitched(_ isReady: Bool)
    func bluetoothManagerDidDiscover(peripheralModel: PeripheralModel)
    func bluetoothManagerDidConnectToPeripheral(with peripheralModel: PeripheralModel)
    func bluetoothManagerDidDisconnectPeripheral(_ peripheralModel: PeripheralModel)
    func bluetoothManagerDidFailToConnectPeripheral(_ peripheralModel: PeripheralModel, error: Error?)
}
