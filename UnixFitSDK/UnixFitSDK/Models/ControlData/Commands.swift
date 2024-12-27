//
//  ControlCommands.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.12.2024.
//

import Foundation

protocol Command {
    var data: Data { get }
    var parametersBytesArray: [UInt8] { get }
    var controlType: CommandType { get }
}

extension Command {
    var parametersBytesArray: [UInt8] {
        []
    }

    var data: Data {
        Data(uint8Bytes: [controlType.rawValue] + parametersBytesArray)
    }
}

struct RequestCommand: Command {
    var controlType: CommandType = .requestControl
}

struct ResetCommand: Command {
    var controlType: CommandType = .reset
}

struct SetTargetSpeedCommand: Command {
    var controlType: CommandType = .setTargetSpeed
    var parametersBytesArray: [UInt8]

    init(targetSpeed: UInt16) {
        self.parametersBytesArray = targetSpeed.getBytes()
    }
}

struct SetTargetInclinationCommand: Command {
    var controlType: CommandType = .setTargetInclination
    var parametersBytesArray: [UInt8]

    init(targetInclination: Int16) {
        self.parametersBytesArray = targetInclination.getBytes()
    }
}

struct SetTargetResistanceCommand: Command {
    var controlType: CommandType = .setTargetResistance
    var parametersBytesArray: [UInt8]

    init(targetResistance: UInt8) {
        self.parametersBytesArray = targetResistance.getBytes()
    }
}

struct SetTargetPowerCommand: Command {
    var controlType: CommandType = .setTargetPower
    var parametersBytesArray: [UInt8]

    init(targetPower: Int16) {
        self.parametersBytesArray = targetPower.getBytes()
    }
}

struct SetTargetHeartRateCommand: Command {
    var controlType: CommandType = .setTargetHeartRate
    var parametersBytesArray: [UInt8]

    init(targetHeartRate: UInt8) {
        self.parametersBytesArray = targetHeartRate.getBytes()
    }
}

enum TrainingCommand: Command {
    case startOrResume
    case stop
    case pause

    var controlType: CommandType {
        switch self {
        case .startOrResume: return .startOrResume
        case .stop, .pause: return .stopOrPause
        }
    }

    var data: Data {
        switch self {
        case .startOrResume: return Data(uint8Bytes: [controlType.rawValue])
        case .stop: return Data(uint8Bytes: [controlType.rawValue, 0x01])
        case .pause: return Data(uint8Bytes: [controlType.rawValue, 0x02])
        }
    }
}

struct SetTargetedEnergyCommand: Command {
    var controlType: CommandType = .setTargetedEnergy
    var parametersBytesArray: [UInt8]

    init(targetedEnergy: UInt16) {
        self.parametersBytesArray = targetedEnergy.getBytes()
    }
}

struct SetTargetedNumberOfStepsCommand: Command {
    var controlType: CommandType = .setTargetedNumberOfSteps
    var parametersBytesArray: [UInt8]

    init(targetedNumberOfSteps: UInt16) {
        self.parametersBytesArray = targetedNumberOfSteps.getBytes()
    }
}

struct SetTargetedNumberOfStridesCommand: Command {
    var controlType: CommandType = .setTargetedNumberOfStrides
    var parametersBytesArray: [UInt8]

    init(targetedNumberOfStrides: UInt16) {
        self.parametersBytesArray = targetedNumberOfStrides.getBytes()
    }
}

struct SetTargetedDistanceCommand: Command {
    var controlType: CommandType = .setTargetedDistance
    var parametersBytesArray: [UInt8]

    init(targetedDistance: UInt32) {
        self.parametersBytesArray = targetedDistance.getBytes()
    }
}

struct SetTargetedTrainingTimeCommand: Command {
    var controlType: CommandType = .setTargetedTrainingTime
    var parametersBytesArray: [UInt8]

    init(targetedTrainingTime: UInt16) {
        self.parametersBytesArray = targetedTrainingTime.getBytes()
    }
}

struct SetTargetedTimeInTwoHeartRateZonesCommand: Command {
    var controlType: CommandType = .setTargetedTimeInTwoHeartRateZones
    var parametersBytesArray: [UInt8]

    init(timeInFatBurnZone: UInt16, timeInFitnessZone: UInt16) {
        self.parametersBytesArray = timeInFatBurnZone.getBytes() + timeInFitnessZone.getBytes()
    }
}

struct SetTargetedTimeInThreeHeartRateZonesCommand: Command {
    var controlType: CommandType = .setTargetedTimeInThreeHeartRateZones
    var parametersBytesArray: [UInt8]

    init(timeInLightZone: UInt16, timeInModerateZone: UInt16, timeInHardZone: UInt16) {
        self.parametersBytesArray = timeInLightZone.getBytes() + timeInModerateZone.getBytes() + timeInHardZone.getBytes()
    }
}

struct SetTargetedTimeInFiveHeartRateZonesCommand: Command {
    var controlType: CommandType = .setTargetedTimeInFiveHeartRateZones
    var parametersBytesArray: [UInt8]

    init(timeInVeryLightZone: UInt16,
         timeInLightZone: UInt16,
         timeInModerateZone: UInt16,
         timeInHardZone: UInt16,
         timeInMaximumZone: UInt16) {
        self.parametersBytesArray = timeInVeryLightZone.getBytes() + timeInLightZone.getBytes() +
            timeInModerateZone.getBytes() + timeInHardZone.getBytes() + timeInMaximumZone.getBytes()
    }
}

struct SetIndoorBikeSimulationParametersCommand: Command {
    var controlType: CommandType = .setIndoorBikeSimulationParameters
    var parametersBytesArray: [UInt8]

    init(windSpeed: Int16, grade: Int16, crr: UInt8, cw: UInt8) {
        self.parametersBytesArray = windSpeed.getBytes() + grade.getBytes() + crr.getBytes() + cw.getBytes()
    }
}

struct SetWheelCircumferenceCommand: Command {
    var controlType: CommandType = .setWheelCircumference
    var parametersBytesArray: [UInt8]

    init(wheelCircumference: UInt16) {
        self.parametersBytesArray = wheelCircumference.getBytes()
    }
}

struct SpinDownControlCommand: Command {
    var controlType: CommandType = .spinDownControl
    var parametersBytesArray: [UInt8]

    init(windSpeed: Int16, grade: Int16, crr: UInt8, cw: UInt8) {
        self.parametersBytesArray = windSpeed.getBytes() + grade.getBytes() + crr.getBytes() + cw.getBytes()
    }
}

struct SetTargetedCadenceCommand: Command {
    var controlType: CommandType = .setTargetedCadence
    var parametersBytesArray: [UInt8]

    init() {
        self.parametersBytesArray = [0x01]
    }
}
