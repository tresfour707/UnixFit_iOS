//
//  ControlType.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.12.2024.
//

import Foundation

enum CommandType: UInt8 {
    case requestControl = 0x00
    case reset = 0x01
    case setTargetSpeed = 0x02
    case setTargetInclination = 0x03
    case setTargetResistance = 0x04
    case setTargetPower = 0x05
    case setTargetHeartRate = 0x06
    case startOrResume = 0x07
    case stopOrPause = 0x08
    case setTargetedEnergy = 0x09
    case setTargetedNumberOfSteps = 0x0A
    case setTargetedNumberOfStrides = 0x0B
    case setTargetedDistance = 0x0C
    case setTargetedTrainingTime = 0x0D
    case setTargetedTimeInTwoHeartRateZones = 0x0E
    case setTargetedTimeInThreeHeartRateZones = 0x0F
    case setTargetedTimeInFiveHeartRateZones = 0x10
    case setIndoorBikeSimulationParameters = 0x11
    case setWheelCircumference = 0x12
    case spinDownControl = 0x13
    case setTargetedCadence = 0x14
}

