//
//  TrainingStatusType.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 17.12.2024.
//

import Foundation

public enum TrainingStatusType: UInt8 {
    case other = 0x00
    case idle = 0x01
    case warmingUp = 0x02
    case lowIntensityInterval = 0x03
    case highIntensityInterval = 0x04
    case recoveryInterval = 0x05
    case isometric = 0x06
    case heartRateControl = 0x07
    case fitnessTest = 0x08
    case speedOutsideOfControlRegionLow = 0x09
    case speedOutsideOfControlRegionHigh = 0x0A
    case coolDown = 0x0B
    case wattControl = 0x0C
    case manualMode = 0x0D
    case preWorkout = 0x0E
    case postWorkout = 0x0F
}
