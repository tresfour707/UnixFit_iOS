//
//  StairClimberData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

struct StairClimberDataOptions: OptionSet {
    let rawValue: UInt16

    static let moreDataNotPresent = StairClimberDataOptions(rawValue: 1 << 0)
    static let stepPerMinute = StairClimberDataOptions(rawValue: 1 << 1)
    static let averageStepRate = StairClimberDataOptions(rawValue: 1 << 2)
    static let positiveElevationGain = StairClimberDataOptions(rawValue: 1 << 3)
    static let strideCount = StairClimberDataOptions(rawValue: 1 << 4)
    static let expendedEnergy = StairClimberDataOptions(rawValue: 1 << 5)
    static let heartRate = StairClimberDataOptions(rawValue: 1 << 6)
    static let metabolicEquivalent = StairClimberDataOptions(rawValue: 1 << 7)
    static let elapsedTime = StairClimberDataOptions(rawValue: 1 << 8)
    static let remainingTime = StairClimberDataOptions(rawValue: 1 << 9)
}

public struct StairClimberRawData {
    public var floorsCount: UInt16?
    public var stepPerMinute: UInt16?
    public var averageStepRate: UInt16?
    public var positiveElevationGain: UInt16?
    public var strideCount: UInt16?
    public var totalEnergy: UInt16?
    public var energyPerHour: UInt16?
    public var energyPerMinute: UInt8?
    public var heartRate: UInt8?
    public var metabolicEquivalent: UInt8?
    public var elapsedTime: UInt16?
    public var remainingTime: UInt16?
}

extension StairClimberRawData {
    init(from data: Data) {
        var fields = Fields<UInt16>(data)
        let options = StairClimberDataOptions(rawValue: fields.flags)

        floorsCount = options.contains(.moreDataNotPresent) ? nil : fields.get()
        stepPerMinute = options.contains(.stepPerMinute) ? fields.get() : nil
        averageStepRate = options.contains(.averageStepRate) ? fields.get() : nil
        positiveElevationGain = options.contains(.positiveElevationGain) ? fields.get() : nil
        strideCount = options.contains(.strideCount) ? fields.get() : nil

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
