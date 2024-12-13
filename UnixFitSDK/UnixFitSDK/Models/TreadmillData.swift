//
//  TreadmillData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct TreadmillRawData {
    var instantaneousSpeed: UInt16
    var averageSpeed: UInt16
    var totalDistance: UInt32
    var inclination: Int16
    var rampAngleSetting: Int16
    var positiveElevationGain: UInt16
    var negativeElevationGain: UInt16
    var instantaneousPace: UInt8
    var averagePace: UInt8
    var totalEnergy: UInt16
    var energyPerHour: UInt16
    var energyPerMinute: UInt8
    var heartRate: UInt8
    var metabolicEquivalent: UInt8
    var elapsedTime: UInt16
    var remainingTime: UInt16
    var forceOnBelt: Int16
    var powerOutput: Int16
    var steps: UInt32
}
