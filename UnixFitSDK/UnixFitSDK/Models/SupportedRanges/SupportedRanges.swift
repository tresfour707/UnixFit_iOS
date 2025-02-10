//
//  SupportedRanges.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 03.02.2025.
//

import Foundation

/// Поддерживаемые значения скорости
public struct SupportedSpeedRange {
    /// Минимальное значение
    public let minSpeed: UInt16

    /// Максимальное значение
    public let maxSpeed: UInt16

    /// Минимальный шаг значения
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

/// Поддерживаемые значения наклона
public struct SupportedInclinationRange {
    /// Минимальное значение
    public let minInclination: Int16

    /// Максимальное значение
    public let maxInclination: Int16

    /// Минимальный шаг значения
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

/// Поддерживаемые значения мощности
public struct SupportedPowerRange {
    /// Минимальное значение
    public let minPower: Int16

    /// Максимальное значение
    public let maxPower: Int16

    /// Минимальный шаг значения
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

/// Поддерживаемые значения сердечного ритма
public struct SupportedHeartRateRange {
    /// Минимальное значение
    public let minHeartRate: UInt8

    /// Максимальное значение
    public let maxHeartRate: UInt8

    /// Минимальный шаг значения
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

/// Поддерживаемые значения сопротивления
public struct SupportedResistanceLevelRange {
    /// Минимальное значение
    public let minResistanceLevel: Int16

    /// Максимальное значение
    public let maxResistanceLevel: Int16

    /// Минимальный шаг значения
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
