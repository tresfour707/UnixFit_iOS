//
//  DeviceData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 14.01.2025.
//

import Foundation

/// Перечисление, хранящее данные тренажеров разных типов
public enum DeviceData {
    case crossTrainer(CrossTrainerRawData)
    case indoorBike(IndoorBikeRawData)
    case rower(RowerRawData)
    case stairClimber(StairClimberRawData)
    case stepClimber(StepClimberRawData)
    case treadmill(TreadmillRawData)
}
