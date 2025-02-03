//
//  SessionManagerDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.01.2025.
//

import Foundation

/// Делегат для получения информации от ``SessionManaging``.
public protocol SessionManagerDelegate: AnyObject {
    /// Функция вызывается при получении от тренажера новых данных
    func sessionManagerDidFetchDeviceData(_ deviceData: DeviceData)

    /// Функция вызывается при получении изменении статуса тренировки
    func sessionManagerDidChangeTrainingStatus(_ trainingStatus: TrainingStatusData)

    /// Функция вызывается после попытки выполнения команды
    func sessionManagerDidCompleteCommand(commandResponse: CommandResponseData)

    /// Функция вызывается при получении списков доступных команд и полей данных
    func sessionManagerDidFetchFTMSFeatures(_ features: FTMSFeaturesData)

    /// Функция вызывается при получении FTMS статуса
    func sessionManagerDidRecieveFTMSStatus(_ ftmsStatus: FTMSStatus)

    /// Функция вызывается при получении поддерживаемого диапазона скоростей
    func sessionManagerDidRecieveSupportedSpeedRange(_ supportedSpeedRange: SupportedSpeedRange)

    /// Функция вызывается при получении поддерживаемого диапазона наклона
    func sessionManagerDidRecieveSupportedInclinationRange(_ supportedInclinationRange: SupportedInclinationRange)

    /// Функция вызывается при получении поддерживаемого диапазона уровней сопротивления
    func sessionManagerDidRecieveSupportedResistanceLevelRange(_ supportedResistanceLevelRange: SupportedResistanceLevelRange)

    /// Функция вызывается при получении поддерживаемого диапазона мощности
    func sessionManagerDidRecieveSupportedPowerRange(_ supportedPowerRange: SupportedPowerRange)

    /// Функция вызывается при получении поддерживаемого диапазона сердечного ритма
    func sessionManagerDidRecieveSupportedHeartRateRange(_ supportedHeartRate: SupportedHeartRateRange)
}

public extension SessionManagerDelegate {
    func sessionManagerDidFetchDeviceData(_ deviceData: DeviceData) { }
    func sessionManagerDidChangeTrainingStatus(_ trainingStatus: TrainingStatusData) { }
    func sessionManagerDidCompleteCommand(commandResponse: CommandResponseData) { }
    func sessionManagerDidFetchFTMSFeatures(_ features: FTMSFeaturesData) { }
    func sessionManagerDidRecieveFTMSStatus(_ ftmsStatus: FTMSStatus) { }
    func sessionManagerDidRecieveSupportedSpeedRange(_ supportedSpeedRange: SupportedSpeedRange) { }
    func sessionManagerDidRecieveSupportedInclinationRange(_ supportedInclinationRange: SupportedInclinationRange) { }
    func sessionManagerDidRecieveSupportedResistanceLevelRange(_ supportedResistanceLevelRange: SupportedResistanceLevelRange) { }
    func sessionManagerDidRecieveSupportedPowerRange(_ supportedPowerRange: SupportedPowerRange) { }
    func sessionManagerDidRecieveSupportedHeartRateRange(_ supportedHeartRate: SupportedHeartRateRange) { }
}
