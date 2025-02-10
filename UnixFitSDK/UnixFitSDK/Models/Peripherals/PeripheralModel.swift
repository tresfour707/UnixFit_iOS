//
//  Peripheral.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 09.01.2025.
//

import CoreBluetooth

/// Структура с данными тренажера
public struct PeripheralModel {
    /// Айдишник
    public var id: UUID {
        peripheral.identifier
    }

    /// Название
    public var name: String? {
        peripheral.name
    }

    /// Флаги, по которым можно вычислить тип тренажера до коннекта
    public var deviceFlags: [UInt8] {
        let serviceDictionary = advertisementData["kCBAdvDataServiceData"] as? [CBUUID: NSData]
        let data = serviceDictionary?[FTMSCharacteristic.serviceFTMS.uuid]
        let flags = data.map { [UInt8]($0) } ?? []

        return flags
    }

    /// CoreBluetooth объект тренажера
    public let peripheral: CBPeripheral

    /// Различные данные тренажера
    public let advertisementData: [String : Any]

    /// Показатель уровня принимаемого сигнала
    public let rssi: NSNumber
}
