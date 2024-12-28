//
//  FTMSCharacteristic.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

enum FTMSCharacteristic: String {
    case serviceFTMS = "1826"

    case FTMSFeature = "2ACC"
    case FTMSStatus = "2ADA"
    case FTMSControlPoint = "2AD9"

    case treadmillData = "2ACD"
    case crossTrainerData = "2ACE"
    case stepClimber = "2ACF"
    case stairClimber = "2AD0"
    case rowerData = "2AD1"
    case indoorBike = "2AD2"

    case trainingStatus = "2AD3"

    var uuid: CBUUID {
        return CBUUID( string: self.rawValue )
    }
}
