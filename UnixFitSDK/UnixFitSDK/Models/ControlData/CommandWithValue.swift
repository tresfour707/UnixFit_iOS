//
//  CommandWithValue.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import Foundation

public enum CommandWithValue {
    case requestControl
    case reset
    case setTargetSpeed(UInt16)
    case setTargetInclination(Int16)
    case setTargetResistance(UInt8)
    case setTargetPower(Int16)
    case setTargetHeartRate(UInt8)
    case startOrResume
    case stopOrPause(isStop: Bool)
    case setTargetedEnergy(UInt16)
    case setTargetedNumberOfSteps(UInt16)
    case setTargetedNumberOfStrides(UInt16)
    case setTargetedDistance(UInt32)
    case setTargetedTrainingTime(UInt16)
    case setTargetedTimeInTwoHeartRateZones(timeInFatBurnZone: UInt16, timeInFitnessZone: UInt16)
    case setTargetedTimeInThreeHeartRateZones(timeInLightZone: UInt16,
                                              timeInModerateZone: UInt16,
                                              timeInHardZone: UInt16)
    case setTargetedTimeInFiveHeartRateZones(timeInVeryLightZone: UInt16,
                                             timeInLightZone: UInt16,
                                             timeInModerateZone: UInt16,
                                             timeInHardZone: UInt16,
                                             timeInMaximumZone: UInt16)
    case setIndoorBikeSimulationParameters(windSpeed: Int16, grade: Int16, crr: UInt8, cw: UInt8)
    case setWheelCircumference(UInt16)
    case spinDownControl
    case setTargetedCadence(UInt16)

    func createCommand() -> Command {
        switch self {
        case .requestControl:
            return RequestCommand()

        case .reset:
            return ResetCommand()

        case .setTargetSpeed(let speed):
            return SetTargetSpeedCommand(targetSpeed: speed)

        case .setTargetInclination(let inclination):
            return SetTargetInclinationCommand(targetInclination: inclination)

        case .setTargetResistance(let resistance):
            return SetTargetResistanceCommand(targetResistance: resistance)

        case .setTargetPower(let power):
            return SetTargetPowerCommand(targetPower: power)

        case .setTargetHeartRate(let heartRate):
            return SetTargetHeartRateCommand(targetHeartRate: heartRate)

        case .startOrResume:
            return TrainingCommand.startOrResume

        case .stopOrPause(let isStop):
            return isStop ? TrainingCommand.stop : TrainingCommand.pause

        case .setTargetedEnergy(let energy):
            return SetTargetedEnergyCommand(targetedEnergy: energy)

        case .setTargetedNumberOfSteps(let steps):
            return SetTargetedNumberOfStepsCommand(targetedNumberOfSteps: steps)

        case .setTargetedNumberOfStrides(let strides):
            return SetTargetedNumberOfStridesCommand(targetedNumberOfStrides: strides)

        case .setTargetedDistance(let distance):
            return SetTargetedDistanceCommand(targetedDistance: distance)

        case .setTargetedTrainingTime(let trainingTime):
            return SetTargetedTrainingTimeCommand(targetedTrainingTime: trainingTime)

        case .setTargetedTimeInTwoHeartRateZones(let timeInFatBurnZone, let timeInFitnessZone):
            return SetTargetedTimeInTwoHeartRateZonesCommand(
                timeInFatBurnZone: timeInFatBurnZone,
                timeInFitnessZone: timeInFitnessZone
            )

        case .setTargetedTimeInThreeHeartRateZones(let timeInLightZone, let timeInModerateZone, let timeInHardZone):
            return SetTargetedTimeInThreeHeartRateZonesCommand(
                timeInLightZone: timeInLightZone,
                timeInModerateZone: timeInModerateZone,
                timeInHardZone: timeInHardZone
            )

        case .setTargetedTimeInFiveHeartRateZones(let timeInVeryLightZone,
                                                  let timeInLightZone,
                                                  let timeInModerateZone,
                                                  let timeInHardZone,
                                                  let timeInMaximumZone):
            return SetTargetedTimeInFiveHeartRateZonesCommand(
                timeInVeryLightZone: timeInVeryLightZone,
                timeInLightZone: timeInLightZone,
                timeInModerateZone: timeInModerateZone,
                timeInHardZone: timeInHardZone,
                timeInMaximumZone: timeInMaximumZone
            )

        case .setIndoorBikeSimulationParameters(let windSpeed, let grade, let crr, let cw):
            return SetIndoorBikeSimulationParametersCommand(windSpeed: windSpeed, grade: grade, crr: crr, cw: cw)

        case .setWheelCircumference(let wheelCircumference):
            return SetWheelCircumferenceCommand(wheelCircumference: wheelCircumference)

        case .spinDownControl:
            return SpinDownControlCommand()

        case .setTargetedCadence(let cadence):
            return SetTargetedCadenceCommand(targetedCadence: cadence)
        }
    }
}
