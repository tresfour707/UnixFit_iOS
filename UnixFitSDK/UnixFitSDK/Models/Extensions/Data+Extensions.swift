//
//  Data+Extensions.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.12.2024.
//

import Foundation

extension Data {
    init(uint8Bytes: [UInt8]) {
        self.init(bytes: uint8Bytes, count: uint8Bytes.count)
    }
}
