//
//  CommandWithValue.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import Foundation

/// Команды  для отправки на тренажер
public enum CommandWithValue {
    /// Получение контроля над тренажером
    case requestControl

    /// Сброс настраиваемых настроек
    case reset

    /// Изменение скорости (0.01 км/ч за единицу)
    case setTargetSpeed(UInt16)

    /// Изменение наклона (0.1% за единицу)
    case setTargetInclination(Int16)

    /// Изменение сопротивления (0.1 за единицу)
    case setTargetResistance(UInt8)

    /// Изменение мощности (1 W за единицу)
    case setTargetPower(Int16)

    /// Изменение целевого ритма сердца (1 BPM за единицу)
    case setTargetHeartRate(UInt8)

    /// Старт или продолжение
    case startOrResume

    /// Стоп при isStop: true, пауза при isStop: false
    case stopOrPause(isStop: Bool)

    /// Изменение целевого количества калорий (1 ккал за единицу)
    case setTargetedEnergy(UInt16)

    /// Изменение целевого количества шагов (1 шаг за единицу)
    case setTargetedNumberOfSteps(UInt16)

    /// Изменение целевого количества шагов (1 шаг за единицу)
    case setTargetedNumberOfStrides(UInt16)

    /// Изменение целевого дистанции (1 метр за единицу).
    /// Тренажер принимает значение в UInt24, но в Swift нет такого типа данных.
    /// Поэтому значение принимается в UInt32, максимальное значение - 16777215
    case setTargetedDistance(UInt32)

    /// Изменение целевого времени тренировки (1 секунда за единицу)
    case setTargetedTrainingTime(UInt16)

    /// Изменение целевого времени тренировки в двух зонах сердечного ритма (1 секунда за единицу)
    case setTargetedTimeInTwoHeartRateZones(timeInFatBurnZone: UInt16, timeInFitnessZone: UInt16)

    /// Изменение целевого времени тренировки в трех зонах сердечного ритма (1 секунда за единицу)
    case setTargetedTimeInThreeHeartRateZones(timeInLightZone: UInt16,
                                              timeInModerateZone: UInt16,
                                              timeInHardZone: UInt16)

    /// Изменение целевого времени тренировки в пяти зонах сердечного ритма (1 секунда за единицу)
    case setTargetedTimeInFiveHeartRateZones(timeInVeryLightZone: UInt16,
                                             timeInLightZone: UInt16,
                                             timeInModerateZone: UInt16,
                                             timeInHardZone: UInt16,
                                             timeInMaximumZone: UInt16)

    /// Настройка симуляции условий для байка
    /// Wind Speed - скорость ветра (0.001 м/c за секунду)
    /// Grade - Уровень (0.01% за единицу)
    /// Crr - Коэффициент трения качения (rolling resistance) (0.0001 за единицу)
    /// Cw - Коэффициент сопротивления ветра (0.01 за единицу)
    case setIndoorBikeSimulationParameters(windSpeed: Int16, grade: Int16, crr: UInt8, cw: UInt8)

    /// Настройка длины окружности колеса (0.1 мм за единицу)
    case setWheelCircumference(UInt16)

    /// Калибровка
    case spinDownControl(SpinDownControlParameterType)

    /// Изменение целевого каденса (0.5 1/м за единицу)
    case setTargetedCadence(UInt16)

    func createCommand() -> Command {
        switch self {
        case .requestControl:
            return RequestCommand()

        case .reset:
            return ResetCommand()

        case .setTargetSpeed(let speed):
            return SetTargetSpeedCommand(targetSpeed: speed)

        case .setTargetInclination(let inclination):
            return SetTargetInclinationCommand(targetInclination: inclination)

        case .setTargetResistance(let resistance):
            return SetTargetResistanceCommand(targetResistance: resistance)

        case .setTargetPower(let power):
            return SetTargetPowerCommand(targetPower: power)

        case .setTargetHeartRate(let heartRate):
            return SetTargetHeartRateCommand(targetHeartRate: heartRate)

        case .startOrResume:
            return TrainingCommand.startOrResume

        case .stopOrPause(let isStop):
            return isStop ? TrainingCommand.stop : TrainingCommand.pause

        case .setTargetedEnergy(let energy):
            return SetTargetedEnergyCommand(targetedEnergy: energy)

        case .setTargetedNumberOfSteps(let steps):
            return SetTargetedNumberOfStepsCommand(targetedNumberOfSteps: steps)

        case .setTargetedNumberOfStrides(let strides):
            return SetTargetedNumberOfStridesCommand(targetedNumberOfStrides: strides)

        case .setTargetedDistance(let distance):
            return SetTargetedDistanceCommand(targetedDistance: distance)

        case .setTargetedTrainingTime(let trainingTime):
            return SetTargetedTrainingTimeCommand(targetedTrainingTime: trainingTime)

        case .setTargetedTimeInTwoHeartRateZones(let timeInFatBurnZone, let timeInFitnessZone):
            return SetTargetedTimeInTwoHeartRateZonesCommand(
                timeInFatBurnZone: timeInFatBurnZone,
                timeInFitnessZone: timeInFitnessZone
            )

        case .setTargetedTimeInThreeHeartRateZones(let timeInLightZone, let timeInModerateZone, let timeInHardZone):
            return SetTargetedTimeInThreeHeartRateZonesCommand(
                timeInLightZone: timeInLightZone,
                timeInModerateZone: timeInModerateZone,
                timeInHardZone: timeInHardZone
            )

        case .setTargetedTimeInFiveHeartRateZones(let timeInVeryLightZone,
                                                  let timeInLightZone,
                                                  let timeInModerateZone,
                                                  let timeInHardZone,
                                                  let timeInMaximumZone):
            return SetTargetedTimeInFiveHeartRateZonesCommand(
                timeInVeryLightZone: timeInVeryLightZone,
                timeInLightZone: timeInLightZone,
                timeInModerateZone: timeInModerateZone,
                timeInHardZone: timeInHardZone,
                timeInMaximumZone: timeInMaximumZone
            )

        case .setIndoorBikeSimulationParameters(let windSpeed, let grade, let crr, let cw):
            return SetIndoorBikeSimulationParametersCommand(windSpeed: windSpeed, grade: grade, crr: crr, cw: cw)

        case .setWheelCircumference(let wheelCircumference):
            return SetWheelCircumferenceCommand(wheelCircumference: wheelCircumference)

        case .spinDownControl(let parameterType):
            return SpinDownControlCommand(parameterType: parameterType)

        case .setTargetedCadence(let cadence):
            return SetTargetedCadenceCommand(targetedCadence: cadence)
        }
    }
}
