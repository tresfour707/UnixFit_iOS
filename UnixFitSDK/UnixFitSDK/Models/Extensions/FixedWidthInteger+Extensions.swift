//
//  FixedWidthInteger+Extensions.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 16.12.2024.
//

import Foundation

extension FixedWidthInteger {
    func getBytes() -> [UInt8] {
        var bytes: [UInt8] = []
        [self.littleEndian].withUnsafeBytes {
            bytes.append(contentsOf: $0)
        }

        return bytes
    }
}
