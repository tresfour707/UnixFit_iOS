//
//  FTMSStatus.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 22.01.2025.
//

import Foundation

/// Статус тренажера. Опционален, может не поддерживаться тренажером.
public enum FTMSStatus {
    /// Неизвестный статус
    case unknown

    /// Сброс
    case reset

    /// Тренировка прекращена или остановлена юзером
    case stoppedOrPausedByUser(isStopped: Bool)

    /// Тренировка прекращена или остановлена при помощи ключа безопасности
    case stoppedBySafetyKey

    /// Тренировка начата или продолжена юзером
    case startedOrResumedByUser

    /// Скорость изменена
    case targetSpeedChanged(UInt16)

    /// Наклон изменен
    case targetInclineChanged(Int16)

    /// Сопротивление изменено
    case targetResistanceChanged(Int16)

    /// Мощность изменена
    case targetPowerChanged(Int16)

    /// Изменен целевой сердечный ритм
    case targetHeartRateChanged(UInt8)

    /// Изменена целевая энергия
    case targetedExpendedEnergyChanged(UInt16)

    /// Изменено целевое количество шагов
    case targetedNumberOfStepsChanged(UInt16)

    /// Изменено целевое количество шагов
    case targetedNumberOfStridesChanged(UInt16)

    /// Изменена целевая дистанция
    case targetedDistanceChanged(UInt32)

    /// Изменено целевое время тренировки
    case targetedTrainingTimeChanged(UInt16)

    /// Изменено целевое время тренировки в двух зонах сердечного ритма
    case targetedTimeInTwoHeartRateZonesChanged(TwoHeartRateZones)

    /// Изменено целевое время тренировки в трех зонах сердечного ритма
    case targetedTimeInThreeHeartRateZonesChanged(ThreeHeartRateZones)

    /// Изменено целевое время тренировки в пяти зонах сердечного ритма
    case targetedTimeInFiveHeartRateZonesChanged(FiveHeartRateZones)

    /// Изменены параметры симуляции
    case indoorBikeSimulationParametersChanged(BikeSimulationParameters)

    /// Изменена длина окружности колеса
    case wheelCircumferenceChanged(UInt16)

    /// Статус калибровки
    case spinDownStatus(SpinDownStatusValue)

    /// Изменен целевой каденс
    case targetedCadenceChanged(UInt16)

    /// Потерян доступ к командам
    case controlPermissionLost

    init(data: Data) {
        var fields = Fields<UInt8>(data)

        switch fields.flags {
        case 0x01: self = .reset
        case 0x02:
            let stoppedFlag: UInt8 = fields.get()
            self = .stoppedOrPausedByUser(isStopped: stoppedFlag == 0x01)
        case 0x03: self = .stoppedBySafetyKey
        case 0x04: self = .startedOrResumedByUser
        case 0x05:
            let speed: UInt16 = fields.get()
            self = .targetSpeedChanged(speed)
        case 0x06:
            let incline: Int16 = fields.get()
            self = .targetInclineChanged(incline)
        case 0x07:
            let resistance: Int16 = fields.get()
            self = .targetResistanceChanged(resistance)
        case 0x08:
            let power: Int16 = fields.get()
            self = .targetPowerChanged(power)
        case 0x09:
            let heartRate: UInt8 = fields.get()
            self = .targetHeartRateChanged(heartRate)
        case 0x0A:
            let expendedEnergy: UInt16 = fields.get()
            self = .targetedExpendedEnergyChanged(expendedEnergy)
        case 0x0B:
            let numberOfSteps: UInt16 = fields.get()
            self = .targetedNumberOfStepsChanged(numberOfSteps)
        case 0x0C:
            let numberOfStrides: UInt16 = fields.get()
            self = .targetedNumberOfStridesChanged(numberOfStrides)
        case 0x0D:
            let distance: UInt32 = fields.get()
            self = .targetedDistanceChanged(distance)
        case 0x0E:
            let trainingTime: UInt16 = fields.get()
            self = .targetedTrainingTimeChanged(trainingTime)
        case 0x0F:
            let targetedTimeInFatBurnZone: UInt16 = fields.get()
            let targetedTimeInFitnessZone: UInt16 = fields.get()
            self = .targetedTimeInTwoHeartRateZonesChanged(
                TwoHeartRateZones(
                    targetedTimeInFatBurnZone: targetedTimeInFatBurnZone,
                    targetedTimeInFitnessZone: targetedTimeInFitnessZone
                )
            )
        case 0x10:
            let targetedTimeInLightZone: UInt16 = fields.get()
            let targetedTimeInModerateZone: UInt16 = fields.get()
            let targetedTimeInHardZone: UInt16 = fields.get()
            self = .targetedTimeInThreeHeartRateZonesChanged(
                ThreeHeartRateZones(
                    targetedTimeInLightZone: targetedTimeInLightZone,
                    targetedTimeInModerateZone: targetedTimeInModerateZone,
                    targetedTimeInHardZone: targetedTimeInHardZone
                )
            )
        case 0x11:
            let targetedTimeInVeryLightZone: UInt16 = fields.get()
            let targetedTimeInLightZone: UInt16 = fields.get()
            let targetedTimeInModerateZone: UInt16 = fields.get()
            let targetedTimeInHardZone: UInt16 = fields.get()
            let targetedTimeInMaximumZone: UInt16 = fields.get()
            self = .targetedTimeInFiveHeartRateZonesChanged(
                FiveHeartRateZones(
                    targetedTimeInVeryLightZone: targetedTimeInVeryLightZone,
                    targetedTimeInLightZone: targetedTimeInLightZone,
                    targetedTimeInModerateZone: targetedTimeInModerateZone,
                    targetedTimeInHardZone: targetedTimeInHardZone,
                    targetedTimeInMaximumZone: targetedTimeInMaximumZone
                )
            )
        case 0x12:
            let windSpeed: Int16 = fields.get()
            let grade: Int16 = fields.get()
            let crr: UInt8 = fields.get()
            let cw: UInt8 = fields.get()
            self = .indoorBikeSimulationParametersChanged(
                BikeSimulationParameters(windSpeed: windSpeed, grade: grade, crr: crr, cw: cw)
            )
        case 0x13:
            let circumference: UInt16 = fields.get()
            self = .wheelCircumferenceChanged(circumference)
        case 0x14:
            let targetSpeedLow: UInt16 = fields.get()
            let targetSpeedHigh: UInt16 = fields.get()
            self = .spinDownStatus(
                SpinDownStatusValue(targetSpeedLow: targetSpeedLow, targetSpeedHigh: targetSpeedHigh)
            )
        case 0x15:
            let cadence: UInt16 = fields.get()
            self = .targetedCadenceChanged(cadence)
        case 0xFF: self = .controlPermissionLost
        default: self = .unknown
        }

    }
}

/// Время в двух зонах сердечного ритма (в секундах)
public struct TwoHeartRateZones {
    public let targetedTimeInFatBurnZone: UInt16
    public let targetedTimeInFitnessZone: UInt16
}

/// Время в трех зонах сердечного ритма (в секундах)
public struct ThreeHeartRateZones {
    public let targetedTimeInLightZone: UInt16
    public let targetedTimeInModerateZone: UInt16
    public let targetedTimeInHardZone: UInt16
}

/// Время в пяти зонах сердечного ритма (в секундах)
public struct FiveHeartRateZones {
    public let targetedTimeInVeryLightZone: UInt16
    public let targetedTimeInLightZone: UInt16
    public let targetedTimeInModerateZone: UInt16
    public let targetedTimeInHardZone: UInt16
    public let targetedTimeInMaximumZone: UInt16
}

/// Параметры симуляции для велосипеда
public struct BikeSimulationParameters {
    /// Скорость ветра (м/c)
    public let windSpeed: Int16

    /// Уровень (%)
    public let grade: Int16

    /// Коэффициент трения качения (rolling resistance)
    public let crr: UInt8

    /// Коэффициент сопротивления ветра
    public let cw: UInt8
}
