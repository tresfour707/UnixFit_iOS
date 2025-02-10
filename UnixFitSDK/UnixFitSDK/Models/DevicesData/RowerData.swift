//
//  RowerData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct RowerDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = RowerDataOptions(rawValue: 1 << 0)
    static let averageStroke = RowerDataOptions(rawValue: 1 << 1)
    static let totalDistance = RowerDataOptions(rawValue: 1 << 2)
    static let instantaneousPace = RowerDataOptions(rawValue: 1 << 3)
    static let averagePace = RowerDataOptions(rawValue: 1 << 4)
    static let instantaneousPower = RowerDataOptions(rawValue: 1 << 5)
    static let averagePower = RowerDataOptions(rawValue: 1 << 6)
    static let resistanceLevel = RowerDataOptions(rawValue: 1 << 7)
    static let expendedEnergy = RowerDataOptions(rawValue: 1 << 8)
    static let heartRate = RowerDataOptions(rawValue: 1 << 9)
    static let metabolicEquivalent = RowerDataOptions(rawValue: 1 << 10)
    static let elapsedTime = RowerDataOptions(rawValue: 1 << 11)
    static let remainingTime = RowerDataOptions(rawValue: 1 << 12)
}

/// Данные гребного тренажера
public struct RowerRawData {
    /// Темп гребли (0.5 гребков за минуту за единицу)
    public var strokeRate: UInt8?

    /// Количество гребков (1 гребок за минуту за единицу)
    public var strokeCount: UInt16?

    /// Средний темп гребли (0.5 гребков за минуту за единицу)
    public var averageStrokeRate: UInt8?

    /// Общая дистанция (1 м за единицу)
    public var totalDistance: UInt32?

    /// Текущий темп (1 с за единицу)
    public var instantaneousPace: UInt16?

    /// Средний темп (1 с за единицу)
    public var averagePace: UInt16?

    /// Текущая мощность (1 W за единицу)
    public var instantaneousPower: Int16?

    /// Средняя мощность (1 W за единицу)
    public var averagePower: Int16?

    /// Уровень сопротивления (0.1 за единицу)
    public var resistanceLevel: Int16?

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

extension RowerRawData {
    init(from data: Data) {
        var fields = Fields<UInt16>(data)
        let options = RowerDataOptions(rawValue: fields.flags)

        if !options.contains(.moreDataNotPresent) {
            strokeRate = fields.get()
            strokeCount = fields.get()
        }

        averageStrokeRate = options.contains(.averageStroke) ? fields.get() : nil

        if options.contains(.totalDistance) {
            let remainder: UInt16 = fields.get()
            let value: UInt8 = fields.get()
            totalDistance = UInt32(value << 16) + UInt32(remainder)
        }

        instantaneousPace = options.contains(.instantaneousPace) ? fields.get() : nil
        averagePace = options.contains(.averagePace) ? fields.get() : nil
        instantaneousPower = options.contains(.instantaneousPower) ? fields.get() : nil
        averagePower = options.contains(.averagePower) ? fields.get() : nil

        resistanceLevel = options.contains(.resistanceLevel) ? fields.get() : nil

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
