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

    let peripheral: CBPeripheral
    let advertisementData: [String : Any]
    let rssi: NSNumber
}
