//
//  IndoorBikeData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct IndoorBikeRawData {
    var instantaneousSpeed: UInt16
    var averageSpeed: UInt16
    var instantaneousCadence: UInt16
    var averageCadence: UInt16
    var totalDistance: UInt32
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
