//
//  TreadmillData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct TreadmillDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = TreadmillDataOptions(rawValue: 1 << 0)
    static let averageSpeed = TreadmillDataOptions(rawValue: 1 << 1)
    static let totalDistance = TreadmillDataOptions(rawValue: 1 << 2)
    static let inclinationAndAngle = TreadmillDataOptions(rawValue: 1 << 3)
    static let elevationGain = TreadmillDataOptions(rawValue: 1 << 4)
    static let instantaneousPace = TreadmillDataOptions(rawValue: 1 << 5)
    static let averagePace = TreadmillDataOptions(rawValue: 1 << 6)
    static let expendedEnergy = TreadmillDataOptions(rawValue: 1 << 7)
    static let heartRate = TreadmillDataOptions(rawValue: 1 << 8)
    static let metabolicEquivalent = TreadmillDataOptions(rawValue: 1 << 9)
    static let elapsedTime = TreadmillDataOptions(rawValue: 1 << 10)
    static let remainingTime = TreadmillDataOptions(rawValue: 1 << 11)
    static let forceOnBeltAndPowerOutput = TreadmillDataOptions(rawValue: 1 << 12)
    static let steps = TreadmillDataOptions(rawValue: 1 << 13)
}

struct TreadmillRawData {
    var instantaneousSpeed: UInt16?
    var averageSpeed: UInt16?
    var totalDistance: UInt32?
    var inclination: Int16?
    var rampAngleSetting: Int16?
    var positiveElevationGain: UInt16?
    var negativeElevationGain: UInt16?
    var instantaneousPace: UInt8?
    var averagePace: UInt8?
    var totalEnergy: UInt16?
    var energyPerHour: UInt16?
    var energyPerMinute: UInt8?
    var heartRate: UInt8?
    var metabolicEquivalent: UInt8?
    var elapsedTime: UInt16?
    var remainingTime: UInt16?
    var forceOnBelt: Int16?
    var powerOutput: Int16?
    var steps: UInt32?
}

extension TreadmillRawData {
    init(from data: Data) {
        var fields = Fields(data)
        let options = TreadmillDataOptions(rawValue: fields.flags)

        instantaneousSpeed = options.contains(.moreDataNotPresent) ? nil : fields.get()
        averageSpeed = options.contains(.averageSpeed) ? fields.get() : nil

        if options.contains(.totalDistance) {
            let remainder: UInt16 = fields.get()
            let value: UInt8 = fields.get()
            totalDistance = UInt32(value << 16) + UInt32(remainder)
        }

        if options.contains(.inclinationAndAngle) {
            inclination = fields.get()
            rampAngleSetting = fields.get()
        }

        if options.contains(.elevationGain) {
            positiveElevationGain = fields.get()
            negativeElevationGain = fields.get()
        }

        instantaneousPace = options.contains(.instantaneousPace) ? fields.get() : nil
        averagePace = options.contains(.averagePace) ? fields.get() : nil

        if options.contains(.expendedEnergy) {
            totalEnergy = fields.get()
            energyPerHour = fields.get()
            energyPerMinute = fields.get()
        }

        heartRate = options.contains(.heartRate) ? fields.get() : nil
        metabolicEquivalent = options.contains(.metabolicEquivalent) ? fields.get() : nil
        elapsedTime = options.contains(.elapsedTime) ? fields.get() : nil
        remainingTime = options.contains(.remainingTime) ? fields.get() : nil

        if options.contains(.forceOnBeltAndPowerOutput) {
            forceOnBelt = fields.get()
            powerOutput = fields.get()
        }

        steps = options.contains(.steps) ? fields.get() : nil
    }
}
