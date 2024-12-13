//
//  CrossTrainerData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct CrossTrainerRawData {
    var instantaneousSpeed: UInt16
    var averageSpeed: UInt16
    var totalDistance: UInt32
    var stepPerMinute: UInt16
    var averageStepRate: UInt16
    var strideCount: UInt16
    var inclination: Int16
    var rampAngleSetting: Int16
    var positiveElevationGain: UInt16
    var negativeElevationGain: UInt16
    var resistanceLevel: Int16
    var instantaneousPower: Int16
    var averagePower: Int16
    var totalEnergy: UInt16
    var energyPerHour: UInt16
    var energyPerMinute: UInt8
    var heartRate: UInt8
    var metabolicEquivalent: UInt8
    var elapsedTime: UInt16
    var remainingTime: UInt16
}
