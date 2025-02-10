//
//  SupportedFTMSFeatures.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 21.01.2025.
//

import Foundation

/// Поддерживаемые тренажером параметры
public enum SupportedFTMSFeature {
    /// Средняя скорость
    case averageSpeed

    /// Каденс
    case cadence

    /// Общая дистанция
    case totalDistance

    /// Уровень наклона
    case inclination

    /// Увеличение подъема
    case elevationGain

    /// Темп
    case pace

    /// Количество шагов
    case stepCount

    /// Уровень сопротивления
    case resistanceLevel

    /// Количество шагов
    case strideCount

    /// Параметры энергии
    case expendedEnergy

    /// Измерение сердечного ритма
    case heartRateMeasurement

    /// Метаболический эквивалент
    case metabolicEquivalent

    /// Прошедшее время
    case elapsedTime

    /// Оставшееся время
    case remainingTime

    /// Измерение мощности
    case powerMeasurement

    /// Оказываемая на ленту беговой дорожки сила
    case forceOnBeltAndPowerOutput

    /// Хранение пользовательских данных
    case userDataRetention
}
