//
//  SessionManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

class SessionManager: NSObject {
    fileprivate var controlCharacteristic: CBCharacteristic?

    func save(controlCharacteristic: CBCharacteristic) {
        self.controlCharacteristic = controlCharacteristic
    }
}
