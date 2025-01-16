//
//  RowerData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct RowerDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = RowerDataOptions(rawValue: 1 << 0)
    static let averageStroke = RowerDataOptions(rawValue: 1 << 1)
    static let totalDistance = RowerDataOptions(rawValue: 1 << 2)
    static let instantaneousPace = RowerDataOptions(rawValue: 1 << 3)
    static let averagePace = RowerDataOptions(rawValue: 1 << 4)
    static let instantaneousPower = RowerDataOptions(rawValue: 1 << 5)
    static let averagePower = RowerDataOptions(rawValue: 1 << 6)
    static let resistanceLevel = RowerDataOptions(rawValue: 1 << 7)
    static let expendedEnergy = RowerDataOptions(rawValue: 1 << 8)
    static let heartRate = RowerDataOptions(rawValue: 1 << 9)
    static let metabolicEquivalent = RowerDataOptions(rawValue: 1 << 10)
    static let elapsedTime = RowerDataOptions(rawValue: 1 << 11)
    static let remainingTime = RowerDataOptions(rawValue: 1 << 12)
}

public struct RowerRawData {
    public var strokeRate: UInt8?
    public var strokeCount: UInt16?
    public var averageStrokeRate: UInt8?
    public var totalDistance: UInt32?
    public var instantaneousPace: UInt16?
    public var averagePace: UInt16?
    public var instantaneousPower: Int16?
    public var averagePower: Int16?
    public var resistanceLevel: Int16?
    public var totalEnergy: UInt16?
    public var energyPerHour: UInt16?
    public var energyPerMinute: UInt8?
    public var heartRate: UInt8?
    public var metabolicEquivalent: UInt8?
    public var elapsedTime: UInt16?
    public var remainingTime: UInt16?
}

extension RowerRawData {
    init(from data: Data) {
        var fields = Fields(data)
        let options = RowerDataOptions(rawValue: fields.flags)

        if !options.contains(.moreDataNotPresent) {
            strokeRate = fields.get()
            strokeCount = fields.get()
        }

        averageStrokeRate = options.contains(.averageStroke) ? fields.get() : nil

        if options.contains(.totalDistance) {
            let remainder: UInt16 = fields.get()
            let value: UInt8 = fields.get()
            totalDistance = UInt32(value << 16) + UInt32(remainder)
        }

        instantaneousPace = options.contains(.instantaneousPace) ? fields.get() : nil
        averagePace = options.contains(.averagePace) ? fields.get() : nil
        instantaneousPower = options.contains(.instantaneousPower) ? fields.get() : nil
        averagePower = options.contains(.averagePower) ? fields.get() : nil

        resistanceLevel = options.contains(.resistanceLevel) ? fields.get() : nil

        if options.contains(.expendedEnergy) {
            totalEnergy = fields.get()
            energyPerHour = fields.get()
            energyPerMinute = fields.get()
        }

        heartRate = options.contains(.heartRate) ? fields.get() : nil
        metabolicEquivalent = options.contains(.metabolicEquivalent) ? fields.get() : nil
        elapsedTime = options.contains(.elapsedTime) ? fields.get() : nil
        remainingTime = options.contains(.remainingTime) ? fields.get() : nil
    }
}
