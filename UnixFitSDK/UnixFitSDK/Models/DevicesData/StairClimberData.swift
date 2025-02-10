//
//  StairClimberData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct StairClimberDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = StairClimberDataOptions(rawValue: 1 << 0)
    static let stepPerMinute = StairClimberDataOptions(rawValue: 1 << 1)
    static let averageStepRate = StairClimberDataOptions(rawValue: 1 << 2)
    static let positiveElevationGain = StairClimberDataOptions(rawValue: 1 << 3)
    static let strideCount = StairClimberDataOptions(rawValue: 1 << 4)
    static let expendedEnergy = StairClimberDataOptions(rawValue: 1 << 5)
    static let heartRate = StairClimberDataOptions(rawValue: 1 << 6)
    static let metabolicEquivalent = StairClimberDataOptions(rawValue: 1 << 7)
    static let elapsedTime = StairClimberDataOptions(rawValue: 1 << 8)
    static let remainingTime = StairClimberDataOptions(rawValue: 1 << 9)
}

/// Данные климбера
public struct StairClimberRawData {
    /// Количество этажей (1 за единицу)
    public var floorsCount: UInt16?

    /// Количество шагов за минуту (1 шаг в минуту за единицу)
    public var stepPerMinute: UInt16?

    /// Среднее количество шагов за минуту (1 шаг в минуту за единицу)
    public var averageStepRate: UInt16?

    /// Набор высоты (1 м за единицу)
    public var positiveElevationGain: UInt16?

    /// Общее количество шагов (1 шаг за единицу)
    public var strideCount: UInt16?

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

extension StairClimberRawData {
    init(from data: Data) {
        var fields = Fields<UInt16>(data)
        let options = StairClimberDataOptions(rawValue: fields.flags)

        floorsCount = options.contains(.moreDataNotPresent) ? nil : fields.get()
        stepPerMinute = options.contains(.stepPerMinute) ? fields.get() : nil
        averageStepRate = options.contains(.averageStepRate) ? fields.get() : nil
        positiveElevationGain = options.contains(.positiveElevationGain) ? fields.get() : nil
        strideCount = options.contains(.strideCount) ? fields.get() : nil

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
