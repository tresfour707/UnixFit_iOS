//
//  TreadmillData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct TreadmillDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = TreadmillDataOptions(rawValue: 1 << 0)
    static let averageSpeed = TreadmillDataOptions(rawValue: 1 << 1)
    static let totalDistance = TreadmillDataOptions(rawValue: 1 << 2)
    static let inclinationAndAngle = TreadmillDataOptions(rawValue: 1 << 3)
    static let elevationGain = TreadmillDataOptions(rawValue: 1 << 4)
    static let instantaneousPace = TreadmillDataOptions(rawValue: 1 << 5)
    static let averagePace = TreadmillDataOptions(rawValue: 1 << 6)
    static let expendedEnergy = TreadmillDataOptions(rawValue: 1 << 7)
    static let heartRate = TreadmillDataOptions(rawValue: 1 << 8)
    static let metabolicEquivalent = TreadmillDataOptions(rawValue: 1 << 9)
    static let elapsedTime = TreadmillDataOptions(rawValue: 1 << 10)
    static let remainingTime = TreadmillDataOptions(rawValue: 1 << 11)
    static let forceOnBeltAndPowerOutput = TreadmillDataOptions(rawValue: 1 << 12)
}

/// Данные беговой дорожки
public struct TreadmillRawData {
    /// Текущая скорость (0.01 км/ч за единицу)
    public var instantaneousSpeed: UInt16?

    /// Средняя скорость (0.01 км/ч за единицу)
    public var averageSpeed: UInt16?

    /// Общая дистанция (1м за единицу)
    public var totalDistance: UInt32?

    /// Уровень наклона (0.1 % за единицу)
    public var inclination: Int16?

    /// Наклон рампы (0.1 градус за единицу)
    public var rampAngleSetting: Int16?

    /// Набор высоты (1 м за единицу)
    public var positiveElevationGain: UInt16?

    /// Уменьшение высоты (1 м за единицу)
    public var negativeElevationGain: UInt16?

    /// Текущий темп (0.1 км/м за единицу)
    public var instantaneousPace: UInt8?

    /// Средний темп (0.1 км/м за единицу)
    public var averagePace: UInt8?

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

    /// Сила на ленту беговой дорожки (1 Н за единицу)
    public var forceOnBelt: Int16?

    /// Выход мощности (1 W за единицу)
    public var powerOutput: Int16?
}

extension TreadmillRawData {
    init(from data: Data) {
        var fields = Fields<UInt16>(data)
        let options = TreadmillDataOptions(rawValue: fields.flags)

        instantaneousSpeed = options.contains(.moreDataNotPresent) ? nil : fields.get()
        averageSpeed = options.contains(.averageSpeed) ? fields.get() : nil

        if options.contains(.totalDistance) {
            let remainder: UInt16 = fields.get()
            let value: UInt8 = fields.get()
            totalDistance = UInt32(value << 16) + UInt32(remainder)
        }

        if options.contains(.inclinationAndAngle) {
            inclination = fields.get()
            rampAngleSetting = fields.get()
        }

        if options.contains(.elevationGain) {
            positiveElevationGain = fields.get()
            negativeElevationGain = fields.get()
        }

        instantaneousPace = options.contains(.instantaneousPace) ? fields.get() : nil
        averagePace = options.contains(.averagePace) ? fields.get() : nil

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

        if options.contains(.forceOnBeltAndPowerOutput) {
            forceOnBelt = fields.get()
            powerOutput = fields.get()
        }
    }
}
