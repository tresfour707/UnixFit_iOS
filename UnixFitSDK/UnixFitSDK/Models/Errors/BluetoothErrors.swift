//
//  BluetoothErrors.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.01.2025.
//

import Foundation

public enum BluetoothError: Error {
    case unknown
    case resetting
    case unsupported
    case unauthorized
    case poweredOff
}
