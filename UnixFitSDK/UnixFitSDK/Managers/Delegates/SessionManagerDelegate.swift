//
//  SessionManagerDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.01.2025.
//

import Foundation

public protocol SessionManagerDelegate: AnyObject {
    func sessionManagerDidFetchDeviceData(_ deviceData: DeviceData)
    func sessionManagerDidChangeTrainingStatus(_ trainingStatus: TrainingStatusData)
    func sessionManagerDidCompleteCommand(commandResponse: CommandResponseData)
}
