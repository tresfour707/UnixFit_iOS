//
//  SupportedRanges.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 03.02.2025.
//

import Foundation

public struct SupportedSpeedRange {
    public let minSpeed: UInt16
    public let maxSpeed: UInt16
    public let minIncrement: UInt16
}

extension SupportedSpeedRange {
    init(from data: Data) {
        var fields = Fields<UInt16>(data)
        minSpeed = fields.flags
        maxSpeed = fields.get()
        minIncrement = fields.get()
    }
}

public struct SupportedInclinationRange {
    public let minInclination: Int16
    public let maxInclination: Int16
    public let minIncrement: UInt16
}

extension SupportedInclinationRange {
    init(from data: Data) {
        var fields = Fields<Int16>(data)
        minInclination = fields.flags
        maxInclination = fields.get()
        minIncrement = fields.get()
    }
}

public struct SupportedPowerRange {
    public let minPower: Int16
    public let maxPower: Int16
    public let minIncrement: UInt16
}

extension SupportedPowerRange {
    init(from data: Data) {
        var fields = Fields<Int16>(data)
        minPower = fields.flags
        maxPower = fields.get()
        minIncrement = fields.get()
    }
}

public struct SupportedHeartRateRange {
    public let minHeartRate: UInt8
    public let maxHeartRate: UInt8
    public let minIncrement: UInt8
}

extension SupportedHeartRateRange {
    init(from data: Data) {
        var fields = Fields<UInt8>(data)
        minHeartRate = fields.flags
        maxHeartRate = fields.get()
        minIncrement = fields.get()
    }
}

public struct SupportedResistanceLevelRange {
    public let minResistanceLevel: Int16
    public let maxResistanceLevel: Int16
    public let minIncrement: UInt16
}

extension SupportedResistanceLevelRange {
    init(from data: Data) {
        var fields = Fields<Int16>(data)
        minResistanceLevel = fields.flags
        maxResistanceLevel = fields.get()
        minIncrement = fields.get()
    }
}
