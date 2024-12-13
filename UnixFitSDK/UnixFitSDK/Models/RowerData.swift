//
//  RowerData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct RowerRawData {
    var srokeRate: UInt8
    var strokeCount: UInt16
    var averageStrokeRate: UInt8
    var totalDistance: UInt32
    var instantaneousPace: UInt16
    var averagePace: UInt16
    var instantaneousPower: Int16
    var averagePower: Int16
    var resistanceLevel: Int16
    var totalEnergy: UInt16
    var energyPerHour: UInt16
    var energyPerMinute: UInt8
    var heartRate: UInt8
    var metabolicEquivalent: UInt8
    var elapsedTime: UInt16
    var remainingTime: UInt16
}
