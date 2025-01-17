//
//  CommandResponseData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 17.01.2025.
//

import Foundation

public struct CommandResponseData {
    var requestCommand: CommandType?
    var resultCode: CommandResponseResultCode?
}

extension CommandResponseData {
    init(from data: Data) {
        let dataBytes = [UInt8](data)
        requestCommand = CommandType(rawValue: dataBytes[1])
        resultCode = CommandResponseResultCode(rawValue: dataBytes[2])
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
