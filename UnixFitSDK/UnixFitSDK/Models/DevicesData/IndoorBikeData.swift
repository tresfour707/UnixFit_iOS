//
//  IndoorBikeData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct IndoorBikeDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = IndoorBikeDataOptions(rawValue: 1 << 0)
    static let averageSpeed = IndoorBikeDataOptions(rawValue: 1 << 1)
    static let instantaneousCadence = IndoorBikeDataOptions(rawValue: 1 << 2)
    static let averageCadence = IndoorBikeDataOptions(rawValue: 1 << 3)
    static let totalDistance = IndoorBikeDataOptions(rawValue: 1 << 4)
    static let resistanceLevel = IndoorBikeDataOptions(rawValue: 1 << 5)
    static let instantaneousPower = IndoorBikeDataOptions(rawValue: 1 << 6)
    static let averagePower = IndoorBikeDataOptions(rawValue: 1 << 7)
    static let expendedEnergy = IndoorBikeDataOptions(rawValue: 1 << 8)
    static let heartRate = IndoorBikeDataOptions(rawValue: 1 << 9)
    static let metabolicEquivalent = IndoorBikeDataOptions(rawValue: 1 << 10)
    static let elapsedTime = IndoorBikeDataOptions(rawValue: 1 << 11)
    static let remainingTime = IndoorBikeDataOptions(rawValue: 1 << 12)
}

/// Данные велотренажера
public struct IndoorBikeRawData {
    /// Текущая скорость (0.01 км/ч за единицу)
    public var instantaneousSpeed: UInt16?

    /// Средняя скорость (0.01 км/ч за единицу)
    public var averageSpeed: UInt16?

    /// Текущий каденс (0.5 1/м за единицу)
    public var instantaneousCadence: UInt16?

    /// Средний каденс (0.5 1/м за единицу)
    public var averageCadence: UInt16?

    /// Общая дистанция (1м за единицу)
    public var totalDistance: UInt32?

    /// Уровень сопротивления (0.1 за единицу)
    public var resistanceLevel: Int16?

    /// Текущая мощность (1 W за единицу)
    public var instantaneousPower: Int16?

    /// Средняя мощность (1 W за единицу)
    public var averagePower: Int16?

    /// Текущая расход калорий (1 ккал за единицу)
    public var totalEnergy: UInt16?

    /// Расход за час (1 ккал в час за единицу)
    public var energyPerHour: UInt16?

    /// Расход за минуту (1 ккал в в минуту за единицу)
    public var energyPerMinute: UInt8?

    /// Сердечный ритм (1 BPM  за единицу)
    public var heartRate: UInt8?

    /// Метаболический эквивалент (1  за единицу)
    public var metabolicEquivalent: UInt8?

    /// Текущее время тренировки (1 с за единицу)
    public var elapsedTime: UInt16?

    /// Оставшееся время тренировки (1 с за единицу)
    public var remainingTime: UInt16?
}

extension IndoorBikeRawData {
    public init(from data: Data) {
        var fields = Fields<UInt16>(data)
        let options = IndoorBikeDataOptions(rawValue: fields.flags)

        instantaneousSpeed = options.contains(.moreDataNotPresent) ? nil : fields.get()
        averageSpeed = options.contains(.averageSpeed) ? fields.get() : nil
        instantaneousCadence = options.contains(.instantaneousCadence) ? fields.get() : nil
        averageCadence = options.contains(.averageCadence) ? fields.get() : nil

        if options.contains(.totalDistance) {
            let remainder: UInt16 = fields.get()
            let value: UInt8 = fields.get()
            totalDistance = UInt32(value << 16) + UInt32(remainder)
        }

        resistanceLevel = options.contains(.resistanceLevel) ? fields.get() : nil
        instantaneousPower = options.contains(.instantaneousPower) ? fields.get() : nil
        averagePower = options.contains(.averagePower) ? fields.get() : nil

        if options.contains(.expendedEnergy) {
            totalEnergy = fields.get()

            let energyPerHour: UInt16 = fields.get()
            self.energyPerHour = energyPerHour == 0xFFFF ? nil : energyPerHour

            let energyPerMinute: UInt8 = fields.get()
            self.energyPerMinute = energyPerMinute == 0xFF ? nil : energyPerMinute
        }

        heartRate = options.contains(.heartRate) ? fields.get() : nil
        metabolicEquivalent = options.contains(.metabolicEquivalent) ? fields.get() : nil
        elapsedTime = options.contains(.elapsedTime) ? fields.get() : nil
        remainingTime = options.contains(.remainingTime) ? fields.get() : nil
    }
}
