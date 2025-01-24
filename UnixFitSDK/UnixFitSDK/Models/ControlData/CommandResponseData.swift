//
//  CommandResponseData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 17.01.2025.
//

import Foundation

public struct CommandResponseData {
    public var requestCommand: CommandType?
    public var resultCode: CommandResponseResultCode?
    public var spinDownStatusValue: SpinDownStatusValue?
}

extension CommandResponseData {
    init(from data: Data) {
        var fields = Fields<UInt8>(data)
        requestCommand = CommandType(rawValue: fields.get())
        resultCode = CommandResponseResultCode(rawValue: fields.get())
        if requestCommand == .spinDownControl, resultCode == .success {
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
