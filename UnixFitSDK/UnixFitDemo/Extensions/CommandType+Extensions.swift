//
//  CommandType+Extensions.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import UnixFitSDK

extension CommandType {
    var title: String {
        switch self {
        case .requestControl:
            return "Request Control"
        case .reset:
            return "Reset"
        case .setTargetSpeed:
            return "Set Target Speed"
        case .setTargetInclination:
            return "Set Target Inclination"
        case .setTargetResistance:
            return "Set Target Resistance"
        case .setTargetPower:
            return "Set Target Power"
        case .setTargetHeartRate:
            return "Set Target Heart Rate"
        case .startOrResume:
            return "Start or Resume"
        case .stopOrPause:
            return "Stop or Pause"
        case .setTargetedEnergy:
            return "Set Targeted Energy"
        case .setTargetedNumberOfSteps:
            return "Set Targeted Number Of Steps"
        case .setTargetedNumberOfStrides:
            return "Set Targeted Number Of Strides"
        case .setTargetedDistance:
            return "Set Targeted Distance"
        case .setTargetedTrainingTime:
            return "Set Targeted Training Time"
        case .setTargetedTimeInTwoHeartRateZones:
            return "Set Targeted Time In Two Heart Rate Zones"
        case .setTargetedTimeInThreeHeartRateZones:
            return "Set Targeted Time In Three Heart Rate Zones"
        case .setTargetedTimeInFiveHeartRateZones:
            return "Set Targeted Time In Five Heart Rate Zones"
        case .setIndoorBikeSimulationParameters:
            return "Set Indoor Bike Simulation Parameters"
        case .setWheelCircumference:
            return "Set Wheel Circumference"
        case .spinDownControl:
            return "Spin Down Control"
        case .setTargetedCadence:
            return "Set Targeted Cadence"
        @unknown default:
            return "Unknown"
        }
    }
}
