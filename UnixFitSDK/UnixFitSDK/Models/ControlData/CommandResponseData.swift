//
//  CommandResponseData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 17.01.2025.
//

import Foundation

/// Структура ответа тренажера на отправленную команду.
public struct CommandResponseData {
    /// Отправленная команда
    public var requestCommand: CommandType?

    /// Код результата
    public var resultCode: CommandResponseResultCode?

    /// Значение статуса Spin Down.  Если была отправлена команда SpinDownControl и она завершилась успешно, здесь может быть значение.
    public var spinDownStatusValue: SpinDownStatusValue?
}

extension CommandResponseData {
    init(from data: Data) {
        var fields = Fields<UInt8>(data)
        requestCommand = CommandType(rawValue: fields.get())
        resultCode = CommandResponseResultCode(rawValue: fields.get())
        if requestCommand == .spinDownControl, resultCode == .success, fields.data.count > 3 {
            let targetSpeedLow: UInt16 = fields.get()
            let targetSpeedHigh: UInt16 = fields.get()
            spinDownStatusValue = SpinDownStatusValue(targetSpeedLow: targetSpeedLow, targetSpeedHigh: targetSpeedHigh)
        }
    }
}

public enum CommandResponseResultCode: UInt8 {
    case other = 0x00
    case success = 0x01
    case notSupported = 0x02
    case invalidParameter = 0x03
    case operationFailed = 0x04
    case controlNotPermitted = 0x05
}
