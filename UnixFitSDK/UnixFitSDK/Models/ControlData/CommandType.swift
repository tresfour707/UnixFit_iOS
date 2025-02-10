//
//  ControlType.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.12.2024.
//

import Foundation

/// Перечисление всех возможных команд
public enum CommandType: UInt8, CaseIterable {
    /// Получение контроля над тренажером
    case requestControl = 0x00

    /// Сброс настраиваемых настроек
    case reset = 0x01

    /// Изменение скорости
    case setTargetSpeed = 0x02

    /// Изменение наклона
    case setTargetInclination = 0x03

    /// Изменение сопротивления
    case setTargetResistance = 0x04

    /// Изменение мощности
    case setTargetPower = 0x05

    /// Изменение целевого ритма сердца
    case setTargetHeartRate = 0x06

    /// Старт или продолжение
    case startOrResume = 0x07

    /// Стоп или пауза
    case stopOrPause = 0x08

    /// Изменение целевого количества ккал
    case setTargetedEnergy = 0x09

    /// Изменение целевого количества шагов
    case setTargetedNumberOfSteps = 0x0A

    /// Изменение целевого количества шагов
    case setTargetedNumberOfStrides = 0x0B

    /// Изменение целевого дистанции
    case setTargetedDistance = 0x0C

    /// Изменение целевого времени тренировки
    case setTargetedTrainingTime = 0x0D

    /// Изменение целевого времени тренировки в двух зонах сердечного ритма
    case setTargetedTimeInTwoHeartRateZones = 0x0E

    /// Изменение целевого времени тренировки в трех зонах сердечного ритма
    case setTargetedTimeInThreeHeartRateZones = 0x0F

    /// Изменение целевого времени тренировки в пяти зонах сердечного ритма
    case setTargetedTimeInFiveHeartRateZones = 0x10

    /// Настройка симуляции условий для байка
    case setIndoorBikeSimulationParameters = 0x11

    /// Настройка длины окружности колеса
    case setWheelCircumference = 0x12

    /// Калибровка
    case spinDownControl = 0x13

    /// Изменение целевого каденса (0.5 1/м за единицу)
    case setTargetedCadence = 0x14
}

