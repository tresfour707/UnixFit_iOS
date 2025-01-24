//
//  FTMSFeaturesData.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 21.01.2025.
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

struct SupportedFTMSFeaturesDataOptions: OptionSet {
    let rawValue: UInt32

    static let averageSpeedSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 0)
    static let cadenceSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 1)
    static let totalDistanceSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 2)
    static let inclinationSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 3)
    static let elevationGainSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 4)
    static let paceSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 5)
    static let stepCountSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 6)
    static let resistanceLevelSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 7)
    static let strideCountSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 8)
    static let expendedEnergySupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 9)
    static let heartRateMeasurementSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 10)
    static let metabolicEquivalentSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 11)
    static let elapsedTimeSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 12)
    static let remainingTimeSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 13)
    static let powerMeasurementSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 14)
    static let forceOnBeltAndPowerOutputSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 15)
    static let userDataRetentionSupported = SupportedFTMSFeaturesDataOptions(rawValue: 1 << 16)
}

public struct FTMSFeaturesData {
    var supportedFeaturesList: [SupportedFTMSFeature]
    var supportedCommandsList: [CommandType]
}

extension FTMSFeaturesData {
    init(from data: Data) {
        let allBytes = [UInt8](data)

        let featuresBytes = allBytes[0..<4]
        let featuresData = Data(uint8Bytes: Array(featuresBytes))
        supportedFeaturesList = FTMSFeaturesData.getSupportedFeatures(from: featuresData)

        let commandsBytes = allBytes[4...]
        let commandsData = Data(uint8Bytes: Array(commandsBytes))
        supportedCommandsList = FTMSFeaturesData.getSupportedCommands(from: commandsData)
    }

    private static func getSupportedCommands(from data: Data) -> [CommandType] {
        let fields = Fields<UInt32>(data)
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

        return supportedCommandsList
    }

    private static func getSupportedFeatures(from data: Data) -> [SupportedFTMSFeature] {
        let fields = Fields<UInt32>(data)
        let options = SupportedFTMSFeaturesDataOptions(rawValue: fields.flags)
        var supportedFeaturesList = [SupportedFTMSFeature]()

        if options.contains(.averageSpeedSupported) { supportedFeaturesList.append(.averageSpeed) }
        if options.contains(.cadenceSupported) { supportedFeaturesList.append(.cadence) }
        if options.contains(.totalDistanceSupported) { supportedFeaturesList.append(.totalDistance) }
        if options.contains(.inclinationSupported) { supportedFeaturesList.append(.inclination) }
        if options.contains(.elevationGainSupported) { supportedFeaturesList.append(.elevationGain) }
        if options.contains(.paceSupported) { supportedFeaturesList.append(.pace) }
        if options.contains(.stepCountSupported) { supportedFeaturesList.append(.stepCount) }
        if options.contains(.resistanceLevelSupported) { supportedFeaturesList.append(.resistanceLevel) }
        if options.contains(.strideCountSupported) { supportedFeaturesList.append(.strideCount) }
        if options.contains(.expendedEnergySupported) { supportedFeaturesList.append(.expendedEnergy) }
        if options.contains(.heartRateMeasurementSupported) { supportedFeaturesList.append(.heartRateMeasurement) }
        if options.contains(.metabolicEquivalentSupported) { supportedFeaturesList.append(.metabolicEquivalent) }
        if options.contains(.elapsedTimeSupported) { supportedFeaturesList.append(.elapsedTime) }
        if options.contains(.remainingTimeSupported) { supportedFeaturesList.append(.remainingTime) }
        if options.contains(.powerMeasurementSupported) { supportedFeaturesList.append(.powerMeasurement) }
        if options.contains(.forceOnBeltAndPowerOutputSupported) {
            supportedFeaturesList.append(.forceOnBeltAndPowerOutput)
        }
        if options.contains(.userDataRetentionSupported) { supportedFeaturesList.append(.userDataRetention) }

        return supportedFeaturesList
    }
}
