//
//  TrainingStatusType.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 17.12.2024.
//

import Foundation

///  Статус тренировки
public enum TrainingStatusType: UInt8 {
    /// Неизвестный статус
    case other = 0x00

    /// Бездействие
    case idle = 0x01

    /// Разминка
    case warmingUp = 0x02

    /// Интервал низкой интенсивности
    case lowIntensityInterval = 0x03

    /// Интервал высокой интенсивности
    case highIntensityInterval = 0x04

    /// Интервал восстановления
    case recoveryInterval = 0x05

    /// Изометрическое упражнение
    case isometric = 0x06

    /// Контроль сердечного ритма
    case heartRateControl = 0x07

    /// Фитнес тест
    case fitnessTest = 0x08

    /// Скорость ниже контрольной
    case speedOutsideOfControlRegionLow = 0x09

    /// Скорость выше контрольной
    case speedOutsideOfControlRegionHigh = 0x0A

    /// Остывание (замедление)
    case coolDown = 0x0B

    /// Watt контроль
    case wattControl = 0x0C

    /// Ручной режим
    case manualMode = 0x0D

    /// Преворкаут
    case preWorkout = 0x0E

    /// Постворкаут
    case postWorkout = 0x0F
}
