//
//  BluetoothErrors.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.01.2025.
//

import Foundation

/// Перечисление с типами ошибок, которые может вернуть ``BluetoothManager`` во время работы с Bluetooth
public enum BluetoothError: Error {
    /// Неизвестная ошибка
    case unknown

    /// Блютуз перезагружается и временно недоступен
    case resetting

    /// Блютуз недоступен на данном устройстве
    case unsupported

    /// Доступ к блютузу не разрешен на данном устройстве
    case unauthorized

    /// Блютуз выключен
    case poweredOff
}
