//
//  CrossTrainerData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct CrossTrainerDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = CrossTrainerDataOptions(rawValue: 1 << 0)
    static let averageSpeed = CrossTrainerDataOptions(rawValue: 1 << 1)
    static let totalDistance = CrossTrainerDataOptions(rawValue: 1 << 2)
    static let stepCount = CrossTrainerDataOptions(rawValue: 1 << 3)
    static let strideCount = CrossTrainerDataOptions(rawValue: 1 << 4)
    static let elevationGain = CrossTrainerDataOptions(rawValue: 1 << 5)
    static let inclinationAndAngle = CrossTrainerDataOptions(rawValue: 1 << 6)
    static let resistanceLevel = CrossTrainerDataOptions(rawValue: 1 << 7)
    static let instantaneousPower = CrossTrainerDataOptions(rawValue: 1 << 8)
    static let averagePower = CrossTrainerDataOptions(rawValue: 1 << 9)
    static let expendedEnergy = CrossTrainerDataOptions(rawValue: 1 << 10)
    static let heartRate = CrossTrainerDataOptions(rawValue: 1 << 11)
    static let metabolicEquivalent = CrossTrainerDataOptions(rawValue: 1 << 12)
    static let elapsedTime = CrossTrainerDataOptions(rawValue: 1 << 13)
    static let remainingTime = CrossTrainerDataOptions(rawValue: 1 << 14)
    static let movementDirection = CrossTrainerDataOptions(rawValue: 1 << 15)
}

struct CrossTrainerRawData {
    var instantaneousSpeed: UInt16?
    var averageSpeed: UInt16?
    var totalDistance: UInt32?
    var stepPerMinute: UInt16?
    var averageStepRate: UInt16?
    var strideCount: UInt16?
    var inclination: Int16?
    var rampAngleSetting: Int16?
    var positiveElevationGain: UInt16?
    var negativeElevationGain: UInt16?
    var resistanceLevel: Int16?
    var instantaneousPower: Int16?
    var averagePower: Int16?
    var totalEnergy: UInt16?
    var energyPerHour: UInt16?
    var energyPerMinute: UInt8?
    var heartRate: UInt8?
    var metabolicEquivalent: UInt8?
    var elapsedTime: UInt16?
    var remainingTime: UInt16?
    var isBackwardDirection: Bool
}

extension CrossTrainerRawData {
    init(from data: Data) {
        var fields = Fields(data)
        let options = CrossTrainerDataOptions(rawValue: fields.flags)

        instantaneousSpeed = options.contains(.moreDataNotPresent) ? nil : fields.get()
        averageSpeed = options.contains(.averageSpeed) ? fields.get() : nil

        if options.contains(.totalDistance) {
            let remainder: UInt16 = fields.get()
            let value: UInt8 = fields.get()
            totalDistance = UInt32(value << 16) + UInt32(remainder)
        }

        if options.contains(.stepCount) {
            stepPerMinute = fields.get()
            averageStepRate = fields.get()
        }

        strideCount = options.contains(.strideCount) ? fields.get() : nil

        if options.contains(.inclinationAndAngle) {
            inclination = fields.get()
            rampAngleSetting = fields.get()
        }

        if options.contains(.elevationGain) {
            positiveElevationGain = fields.get()
            negativeElevationGain = fields.get()
        }

        resistanceLevel = options.contains(.resistanceLevel) ? fields.get() : nil
        instantaneousPower = options.contains(.instantaneousPower) ? fields.get() : nil
        averagePower = options.contains(.averagePower) ? fields.get() : nil

        if options.contains(.expendedEnergy) {
            totalEnergy = fields.get()
            energyPerHour = fields.get()
            energyPerMinute = fields.get()
        }

        heartRate = options.contains(.heartRate) ? fields.get() : nil
        metabolicEquivalent = options.contains(.metabolicEquivalent) ? fields.get() : nil
        elapsedTime = options.contains(.elapsedTime) ? fields.get() : nil
        remainingTime = options.contains(.remainingTime) ? fields.get() : nil

        isBackwardDirection = options.contains(.movementDirection)
    }
}
