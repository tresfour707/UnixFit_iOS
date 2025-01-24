//
//  TrainingStatusType+Extensions.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 20.01.2025.
//

import UnixFitSDK

extension TrainingStatusType {
    var title: String {
        switch self {
        case .other:
            return "Неизвестный статус"
        case .idle:
            return "Бездействие"
        case .warmingUp:
            return "Разминка"
        case .lowIntensityInterval:
            return "Интервал низкой интенсивности"
        case .highIntensityInterval:
            return "Интервал высокой интенсивности"
        case .recoveryInterval:
            return "Интервал восстановления"
        case .isometric:
            return "Изометрическое упражнение"
        case .heartRateControl:
            return "Контроль сердечного ритма"
        case .fitnessTest:
            return "Фитнесс тест"
        case .speedOutsideOfControlRegionLow:
            return "Скорость ниже контрольной"
        case .speedOutsideOfControlRegionHigh:
            return "Скорость выше контрольной"
        case .coolDown:
            return "Остывание (замедление)"
        case .wattControl:
            return "Watt контроль"
        case .manualMode:
            return "Ручной режим"
        case .preWorkout:
            return "Преворкаут"
        case .postWorkout:
            return "Постворкаут"
        @unknown default:
            return "Неизвестный статус"
        }
    }
}
