//
//  Peripheral.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 09.01.2025.
//

import CoreBluetooth

public struct PeripheralModel {
    public var id: UUID {
        peripheral.identifier
    }

    public var name: String? {
        peripheral.name
    }

    public var deviceFlags: [UInt8] {
        let serviceDictionary = advertisementData["kCBAdvDataServiceData"] as? [CBUUID: NSData]
        let data = serviceDictionary?[FTMSCharacteristic.serviceFTMS.uuid]
        let flags = data.map { [UInt8]($0) } ?? []
        let zeroCountToAppend = 6 - flags.count

        return Array(repeating: 0, count: zeroCountToAppend) + flags
    }

    public let peripheral: CBPeripheral
    public let advertisementData: [String : Any]
    public let rssi: NSNumber
}
