//
//  SessionManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

public protocol SessionManaging: AnyObject {
    
}

class SessionManager: NSObject, SessionManaging {
    private let peripheralModel: PeripheralModel
    fileprivate var controlCharacteristic: CBCharacteristic?

    init(peripheralModel: PeripheralModel) {
        self.peripheralModel = peripheralModel

        peripheralModel.peripheral.discoverServices([FTMSCharacteristic.serviceFTMS.uuid])
    }

    // MARK: - Public methods
    public func send(command: Command) {
        guard let controlCharacteristic else {
            return
        }
        peripheralModel.peripheral.writeValue(command.data, for: controlCharacteristic, type: .withResponse)
    }

    // MARK: - Internal methods
    func save(controlCharacteristic: CBCharacteristic) {
        self.controlCharacteristic = controlCharacteristic
    }
}
