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
            return "Set Target Speed (0.01 km/h)"
        case .setTargetInclination:
            return "Set Target Inclination (0.1 %)"
        case .setTargetResistance:
            return "Set Target Resistance (0.1)"
        case .setTargetPower:
            return "Set Target Power (1 W)"
        case .setTargetHeartRate:
            return "Set Target Heart Rate (1 BPM)"
        case .startOrResume:
            return "Start or Resume"
        case .stopOrPause:
            return "Stop or Pause"
        case .setTargetedEnergy:
            return "Set Targeted Energy (1 Calorie)"
        case .setTargetedNumberOfSteps:
            return "Set Targeted Number Of Steps (1 Step)"
        case .setTargetedNumberOfStrides:
            return "Set Targeted Number Of Strides (1 Stride)"
        case .setTargetedDistance:
            return "Set Targeted Distance (1 m)"
        case .setTargetedTrainingTime:
            return "Set Targeted Training Time (1 s)"
        case .setTargetedTimeInTwoHeartRateZones:
            return "Set Targeted Time In Two Heart Rate Zones"
        case .setTargetedTimeInThreeHeartRateZones:
            return "Set Targeted Time In Three Heart Rate Zones"
        case .setTargetedTimeInFiveHeartRateZones:
            return "Set Targeted Time In Five Heart Rate Zones"
        case .setIndoorBikeSimulationParameters:
            return "Set Indoor Bike Simulation Parameters"
        case .setWheelCircumference:
            return "Set Wheel Circumference (0.1 mm)"
        case .spinDownControl:
            return "Spin Down Control"
        case .setTargetedCadence:
            return "Set Targeted Cadence (0.5 1/minute)"
        @unknown default:
            return "Unknown"
        }
    }
}
