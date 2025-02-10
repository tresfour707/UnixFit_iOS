//
//  SpinDownStatus.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 22.01.2025.
//

import Foundation

/// Значение статуса Spin Down.
public struct SpinDownStatusValue {
    /// Нижняя граница скорости (0.01 км/ч за единицу)
    public let targetSpeedLow: UInt16
    /// Верхняя граница скорости (0.01 км/ч за единицу)
    public let targetSpeedHigh: UInt16
}
