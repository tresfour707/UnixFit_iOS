//
//  BluetoothManagerDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 28.12.2024.
//

import Foundation

/// Делегат для получения информации от ``BluetoothManager``.
public protocol BluetoothManagerDelegate: AnyObject {
    /// Функция сигнализирует об ошибке при работе с Bluetooth
    func bluetoothManagerDidFail(with error: BluetoothError)

    /// Функция вызывается при изменении флага isReady, который сообщает о возможности поиска и взаимодействия с устройствами
    func bluetoothManagerDidReadyStateSwitched(_ isReady: Bool)

    /// Функция возвращает структуру найденного устройства
    func bluetoothManagerDidDiscover(peripheralModel: PeripheralModel)

    /// Функция оповещает об успешном подключении устройства
    func bluetoothManagerDidConnectToPeripheral(with peripheralModel: PeripheralModel)

    /// Функция оповещает о дисконнекте устройства
    func bluetoothManagerDidDisconnectPeripheral(_ peripheralModel: PeripheralModel)

    /// Функция сообщает об ошибке подключения устройства
    func bluetoothManagerDidFailToConnectPeripheral(_ peripheralModel: PeripheralModel, error: Error?)
}
