//
//  SupportedCommandsData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 15.01.2025.
//

import Foundation

struct SupportedCommandsDataOptions: OptionSet {
    let rawValue: UInt32

    static let setTargetSpeedSupported = SupportedCommandsDataOptions(rawValue: 1 << 0)
    static let setTargetInclinationSupported = SupportedCommandsDataOptions(rawValue: 1 << 1)
    static let setTargetResistanceSupported = SupportedCommandsDataOptions(rawValue: 1 << 2)
    static let setTargetPowerSupported = SupportedCommandsDataOptions(rawValue: 1 << 3)
    static let setTargetHeartRateSupported = SupportedCommandsDataOptions(rawValue: 1 << 4)
    static let setTargetedEnergySupported = SupportedCommandsDataOptions(rawValue: 1 << 5)
    static let setTargetedNumberOfStepsSupported = SupportedCommandsDataOptions(rawValue: 1 << 6)
    static let setTargetedNumberOfStridesSupported = SupportedCommandsDataOptions(rawValue: 1 << 7)
    static let setTargetedDistanceSupported = SupportedCommandsDataOptions(rawValue: 1 << 8)
    static let setTargetedTrainingTimeSupported = SupportedCommandsDataOptions(rawValue: 1 << 9)
    static let setTargetedTimeInTwoHeartRateZonesSupported = SupportedCommandsDataOptions(rawValue: 1 << 10)
    static let setTargetedTimeInThreeHeartRateZonesSupported = SupportedCommandsDataOptions(rawValue: 1 << 11)
    static let setTargetedTimeInFiveHeartRateZonesSupported = SupportedCommandsDataOptions(rawValue: 1 << 12)
    static let setIndoorBikeSimulationParametersSupported = SupportedCommandsDataOptions(rawValue: 1 << 13)
    static let setWheelCircumferenceSupported = SupportedCommandsDataOptions(rawValue: 1 << 14)
    static let spinDownControlSupported = SupportedCommandsDataOptions(rawValue: 1 << 15)
    static let setTargetedCadenceSupported = SupportedCommandsDataOptions(rawValue: 1 << 16)
}

struct SupportedCommandsData {
    var supportedCommandsList: [CommandType]
}

extension SupportedCommandsData {
    init(from data: Data) {
        let allBytes = [UInt8](data)
    
        let commandsBytes = allBytes[4...]
        let commandsData = Data(uint8Bytes: Array(commandsBytes))

        let fields = Fields<UInt32>(commandsData)
        let options = SupportedCommandsDataOptions(rawValue: fields.flags)
        var supportedCommandsList = [CommandType]()
        supportedCommandsList.append(contentsOf: [.requestControl, .reset, .startOrResume, .stopOrPause])
        if options.contains(.setTargetSpeedSupported) { supportedCommandsList.append(.setTargetSpeed) }
        if options.contains(.setTargetInclinationSupported) { supportedCommandsList.append(.setTargetInclination) }
        if options.contains(.setTargetResistanceSupported) { supportedCommandsList.append(.setTargetResistance) }
        if options.contains(.setTargetPowerSupported) { supportedCommandsList.append(.setTargetPower) }
        if options.contains(.setTargetHeartRateSupported) { supportedCommandsList.append(.setTargetHeartRate) }
        if options.contains(.setTargetedEnergySupported) { supportedCommandsList.append(.setTargetedEnergy) }
        if options.contains(.setTargetedNumberOfStepsSupported) {
            supportedCommandsList.append(.setTargetedNumberOfSteps)
        }
        if options.contains(.setTargetedNumberOfStridesSupported) {
            supportedCommandsList.append(.setTargetedNumberOfStrides)
        }
        if options.contains(.setTargetedDistanceSupported) { supportedCommandsList.append(.setTargetedDistance) }
        if options.contains(.setTargetedTrainingTimeSupported) {
            supportedCommandsList.append(.setTargetedTrainingTime)
        }
        if options.contains(.setTargetedTimeInTwoHeartRateZonesSupported) {
            supportedCommandsList.append(.setTargetedTimeInTwoHeartRateZones)
        }
        if options.contains(.setTargetedTimeInThreeHeartRateZonesSupported) {
            supportedCommandsList.append(.setTargetedTimeInThreeHeartRateZones)
        }
        if options.contains(.setTargetedTimeInFiveHeartRateZonesSupported) {
            supportedCommandsList.append(.setTargetedTimeInFiveHeartRateZones)
        }
        if options.contains(.setIndoorBikeSimulationParametersSupported) {
            supportedCommandsList.append(.setIndoorBikeSimulationParameters)
        }
        if options.contains(.setWheelCircumferenceSupported) {
            supportedCommandsList.append(.setWheelCircumference)
        }
        if options.contains(.spinDownControlSupported) { supportedCommandsList.append(.spinDownControl) }
        if options.contains(.setTargetedCadenceSupported) { supportedCommandsList.append(.setTargetedCadence) }
        self.supportedCommandsList = supportedCommandsList
    }
}
