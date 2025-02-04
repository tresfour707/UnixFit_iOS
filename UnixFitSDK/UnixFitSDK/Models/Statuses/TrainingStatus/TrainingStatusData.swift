//
//  TrainingStatusData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import Foundation

struct TrainingStatusDataOptions: OptionSet {
    let rawValue: UInt8

    static let trainingStatusStringPresent = TrainingStatusDataOptions(rawValue: 1 << 0)
    static let extendedStringPresent = TrainingStatusDataOptions(rawValue: 1 << 1)
}

public struct TrainingStatusData {
    public var statusType: TrainingStatusType
}

extension TrainingStatusData {
    init(from data: Data) {
        var fields = Fields<UInt8>(data)
        if data.count > 1 {
            let statusByte: UInt8 = fields.get()
            statusType = TrainingStatusType(rawValue: statusByte) ?? .other
        } else {
            statusType = .other
        }
    }
}
