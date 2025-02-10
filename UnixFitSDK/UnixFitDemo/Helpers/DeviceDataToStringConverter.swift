//
//  DeviceDataToStringConverter.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 14.01.2025.
//

import Foundation
import UnixFitSDK

final class DeviceDataToStringConverter {
    static func convertFromTreadmillData(_ treadmillData: TreadmillRawData) -> String {
        var resultStrings = [String]()
        resultStrings.append("Treadmill Data")
        resultStrings.append("Average Pace: " + tryToConvertToString(treadmillData.averagePace))
        resultStrings.append("Average Speed: " + tryToConvertToString(treadmillData.averageSpeed))
        resultStrings.append("Elapsed Time: " + tryToConvertToString(treadmillData.elapsedTime))
        resultStrings.append("Energy Per Hour: " + tryToConvertToString(treadmillData.energyPerHour))
        resultStrings.append("Energy Per Minute: " + tryToConvertToString(treadmillData.energyPerMinute))
        resultStrings.append("Force On Belt: " + tryToConvertToString(treadmillData.forceOnBelt))
        resultStrings.append("Heart Rate: " + tryToConvertToString(treadmillData.heartRate))
        resultStrings.append("Inclination: " + tryToConvertToString(treadmillData.inclination))
        resultStrings.append("Instantaneous Pace: " + tryToConvertToString(treadmillData.instantaneousPace))
        resultStrings.append("Instantaneous Speed: " + tryToConvertToString(treadmillData.instantaneousSpeed))
        resultStrings.append("Metabolic Equivalent: " + tryToConvertToString(treadmillData.metabolicEquivalent))
        resultStrings.append("Negative Elevation Gain: " + tryToConvertToString(treadmillData.negativeElevationGain))
        resultStrings.append("Positive Elevation Gain: " + tryToConvertToString(treadmillData.positiveElevationGain))
        resultStrings.append("Power Output: " + tryToConvertToString(treadmillData.powerOutput))
        resultStrings.append("Ramp Angle Setting: " + tryToConvertToString(treadmillData.rampAngleSetting))
        resultStrings.append("Remaining Time: " + tryToConvertToString(treadmillData.remainingTime))
        resultStrings.append("Total Distance: " + tryToConvertToString(treadmillData.totalDistance))
        resultStrings.append("Total Energy: " + tryToConvertToString(treadmillData.totalEnergy))

        return resultStrings.joined(separator: "\n")
    }

    static func convertFromCrossTrainerData(_ crossTrainerData: CrossTrainerRawData) -> String {
        var resultStrings = [String]()
        resultStrings.append("Cross Trainer Data")
        resultStrings.append("Average Power: " + tryToConvertToString(crossTrainerData.averagePower))
        resultStrings.append("Average Speed: " + tryToConvertToString(crossTrainerData.averageSpeed))
        resultStrings.append("Average Step Rate: " + tryToConvertToString(crossTrainerData.averageStepRate))
        resultStrings.append("Elapsed Time: " + tryToConvertToString(crossTrainerData.elapsedTime))
        resultStrings.append("Energy Per Hour: " + tryToConvertToString(crossTrainerData.energyPerHour))
        resultStrings.append("Energy Per Minute: " + tryToConvertToString(crossTrainerData.energyPerMinute))
        resultStrings.append("Heart Rate: " + tryToConvertToString(crossTrainerData.heartRate))
        resultStrings.append("Inclination: " + tryToConvertToString(crossTrainerData.inclination))
        resultStrings.append("Instantaneous Power: " + tryToConvertToString(crossTrainerData.instantaneousPower))
        resultStrings.append("Instantaneous Speed: " + tryToConvertToString(crossTrainerData.instantaneousSpeed))
        resultStrings.append("Is Backward Direction: " + tryToConvertToString(crossTrainerData.isBackwardDirection))
        resultStrings.append("Metabolic Equivalent: " + tryToConvertToString(crossTrainerData.metabolicEquivalent))
        resultStrings.append("Negative Elevation Gain: " + tryToConvertToString(crossTrainerData.negativeElevationGain))
        resultStrings.append("Positive Elevation Gain: " + tryToConvertToString(crossTrainerData.positiveElevationGain))
        resultStrings.append("Ramp Angle Setting: " + tryToConvertToString(crossTrainerData.rampAngleSetting))
        resultStrings.append("Remaining Time: " + tryToConvertToString(crossTrainerData.remainingTime))
        resultStrings.append("Resistance Level: " + tryToConvertToString(crossTrainerData.resistanceLevel))
        resultStrings.append("Step Per Minute: " + tryToConvertToString(crossTrainerData.stepPerMinute))
        resultStrings.append("Sride Count: " + tryToConvertToString(crossTrainerData.strideCount))
        resultStrings.append("Total Distance: " + tryToConvertToString(crossTrainerData.totalDistance))
        resultStrings.append("Total Energy: " + tryToConvertToString(crossTrainerData.totalEnergy))

        return resultStrings.joined(separator: "\n")
    }

    static func convertFromIndoorBikeData(_ indoorBikeData: IndoorBikeRawData) -> String {
        var resultStrings = [String]()
        resultStrings.append("Indoor Bike Data")
        resultStrings.append("Average Cadence: " + tryToConvertToString(indoorBikeData.averageCadence))
        resultStrings.append("Average Power: " + tryToConvertToString(indoorBikeData.averagePower))
        resultStrings.append("Average Speed: " + tryToConvertToString(indoorBikeData.averageSpeed))
        resultStrings.append("Elapsed Time: " + tryToConvertToString(indoorBikeData.elapsedTime))
        resultStrings.append("Energy Per Hour: " + tryToConvertToString(indoorBikeData.energyPerHour))
        resultStrings.append("Energy Per Minute: " + tryToConvertToString(indoorBikeData.energyPerMinute))
        resultStrings.append("Heart Rate: " + tryToConvertToString(indoorBikeData.heartRate))
        resultStrings.append("Instantaneous Cadence: " + tryToConvertToString(indoorBikeData.instantaneousCadence))
        resultStrings.append("Instantaneous Power: " + tryToConvertToString(indoorBikeData.instantaneousPower))
        resultStrings.append("Instantaneous Speed: " + tryToConvertToString(indoorBikeData.instantaneousSpeed))
        resultStrings.append("Metabolic Equivalent: " + tryToConvertToString(indoorBikeData.metabolicEquivalent))
        resultStrings.append("Remaining Time: " + tryToConvertToString(indoorBikeData.remainingTime))
        resultStrings.append("Resistance Level: " + tryToConvertToString(indoorBikeData.resistanceLevel))
        resultStrings.append("Total Distance: " + tryToConvertToString(indoorBikeData.totalDistance))
        resultStrings.append("Total Energy: " + tryToConvertToString(indoorBikeData.totalEnergy))

        return resultStrings.joined(separator: "\n")
    }

    static func convertFromRowerData(_ rowerData: RowerRawData) -> String {
        var resultStrings = [String]()
        resultStrings.append("Rower Data")
        resultStrings.append("Average Pace: " + tryToConvertToString(rowerData.averagePace))
        resultStrings.append("Average Power: " + tryToConvertToString(rowerData.averagePower))
        resultStrings.append("Average Stroke Rate: " + tryToConvertToString(rowerData.averageStrokeRate))
        resultStrings.append("Elapsed Time: " + tryToConvertToString(rowerData.elapsedTime))
        resultStrings.append("Energy Per Hour: " + tryToConvertToString(rowerData.energyPerHour))
        resultStrings.append("Energy Per Minute: " + tryToConvertToString(rowerData.energyPerMinute))
        resultStrings.append("Heart Rate: " + tryToConvertToString(rowerData.heartRate))
        resultStrings.append("Instantaneous Pace: " + tryToConvertToString(rowerData.instantaneousPace))
        resultStrings.append("Instantaneous Power: " + tryToConvertToString(rowerData.instantaneousPower))
        resultStrings.append("Metabolic Equivalent: " + tryToConvertToString(rowerData.metabolicEquivalent))
        resultStrings.append("Remaining Time: " + tryToConvertToString(rowerData.remainingTime))
        resultStrings.append("Resistance Level: " + tryToConvertToString(rowerData.resistanceLevel))
        resultStrings.append("Stroke Count: " + tryToConvertToString(rowerData.strokeCount))
        resultStrings.append("Stroke Rate: " + tryToConvertToString(rowerData.strokeRate))
        resultStrings.append("Total Distance: " + tryToConvertToString(rowerData.totalDistance))
        resultStrings.append("Total Energy: " + tryToConvertToString(rowerData.totalEnergy))

        return resultStrings.joined(separator: "\n")
    }

    static func convertFromStairClimberData(_ stairClimberData: StairClimberRawData) -> String {
        var resultStrings = [String]()
        resultStrings.append("Stair Climber Data")
        resultStrings.append("Average Step Rate: " + tryToConvertToString(stairClimberData.averageStepRate))
        resultStrings.append("Elapsed Time: " + tryToConvertToString(stairClimberData.elapsedTime))
        resultStrings.append("Energy Per Hour: " + tryToConvertToString(stairClimberData.energyPerHour))
        resultStrings.append("Energy Per Minute: " + tryToConvertToString(stairClimberData.energyPerMinute))
        resultStrings.append("Heart Rate: " + tryToConvertToString(stairClimberData.heartRate))
        resultStrings.append("Metabolic Equivalent: " + tryToConvertToString(stairClimberData.metabolicEquivalent))
        resultStrings.append("Positive Elevation Gain: " + tryToConvertToString(stairClimberData.positiveElevationGain))
        resultStrings.append("Remaining Time: " + tryToConvertToString(stairClimberData.remainingTime))
        resultStrings.append("Step Per Minute: " + tryToConvertToString(stairClimberData.stepPerMinute))
        resultStrings.append("Stride Count: " + tryToConvertToString(stairClimberData.strideCount))
        resultStrings.append("Total Energy: " + tryToConvertToString(stairClimberData.totalEnergy))

        return resultStrings.joined(separator: "\n")
    }

    static func convertFromStepClimberData(_ stepClimber: StepClimberRawData) -> String {
        var resultStrings = [String]()
        resultStrings.append("Step Climber Data")
        resultStrings.append("Average Step Rate: " + tryToConvertToString(stepClimber.averageStepRate))
        resultStrings.append("Elapsed Time: " + tryToConvertToString(stepClimber.elapsedTime))
        resultStrings.append("Energy Per Hour: " + tryToConvertToString(stepClimber.energyPerHour))
        resultStrings.append("Energy Per Minute: " + tryToConvertToString(stepClimber.energyPerMinute))
        resultStrings.append("Floors Count: " + tryToConvertToString(stepClimber.floorsCount))
        resultStrings.append("Heart Rate: " + tryToConvertToString(stepClimber.heartRate))
        resultStrings.append("Metabolic Equivalent: " + tryToConvertToString(stepClimber.metabolicEquivalent))
        resultStrings.append("Positive Elevation Gain: " + tryToConvertToString(stepClimber.positiveElevationGain))
        resultStrings.append("Remaining Time: " + tryToConvertToString(stepClimber.remainingTime))
        resultStrings.append("Step Count: " + tryToConvertToString(stepClimber.stepCount))
        resultStrings.append("Step Per Minute: " + tryToConvertToString(stepClimber.stepPerMinute))
        resultStrings.append("Total Energy: " + tryToConvertToString(stepClimber.totalEnergy))

        return resultStrings.joined(separator: "\n")
    }

    private static func tryToConvertToString<T: LosslessStringConvertible>(_ parameter: T?) -> String {
        parameter.map { String($0) } ?? "Unavailable"
    }
}
