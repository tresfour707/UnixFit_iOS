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

public struct TreadmillRawData {
    public var instantaneousSpeed: UInt16?
    public var averageSpeed: UInt16?
    public var totalDistance: UInt32?
    public var inclination: Int16?
    public var rampAngleSetting: Int16?
    public var positiveElevationGain: UInt16?
    public var negativeElevationGain: UInt16?
    public var instantaneousPace: UInt8?
    public var averagePace: UInt8?
    public var totalEnergy: UInt16?
    public var energyPerHour: UInt16?
    public var energyPerMinute: UInt8?
    public var heartRate: UInt8?
    public var metabolicEquivalent: UInt8?
    public var elapsedTime: UInt16?
    public var remainingTime: UInt16?
    public var forceOnBelt: Int16?
    public var powerOutput: Int16?
    public var steps: UInt32?
}

extension TreadmillRawData {
    init(from data: Data) {
        var fields = Fields<UInt16>(data)
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

            let energyPerHour: UInt16 = fields.get()
            self.energyPerHour = energyPerHour == 0xFFFF ? nil : energyPerHour

            let energyPerMinute: UInt8 = fields.get()
            self.energyPerMinute = energyPerMinute == 0xFF ? nil : energyPerMinute
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
