//
//  StairClimberData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct StairClimberRawData {
    var floorsCount: UInt16
    var stepPerMinute: UInt16
    var averageStepRate: UInt16
    var positiveElevationGain: UInt16
    var strideCount: UInt16
    var totalEnergy: UInt16
    var energyPerHour: UInt16
    var energyPerMinute: UInt8
    var heartRate: UInt8
    var metabolicEquivalent: UInt8
    var elapsedTime: UInt16
    var remainingTime: UInt16
}
