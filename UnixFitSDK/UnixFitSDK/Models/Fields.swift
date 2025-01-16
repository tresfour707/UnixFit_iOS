//
//  Fields.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 13.12.2024.
//

import Foundation

private extension FixedWidthInteger {
    var byteWidth: Int {
        return self.bitWidth / UInt8.bitWidth
    }
    static var byteWidth: Int {
        return Self.bitWidth / UInt8.bitWidth
    }
}

struct Fields {
    var flags: UInt16 = 0
    var data: Data
    var offset = 0

    init(_ data: Data) {
        self.data = data
        self.flags = get()
    }

    mutating func get<T: FixedWidthInteger>() -> T {
        let byteWidth = T.self.byteWidth
        var value: T = 0

        data.subdata(
            in: data.startIndex.advanced(by: offset)..<data.startIndex.advanced(by: offset + byteWidth)
        ).withUnsafeBytes { bytes in
            value = bytes.load(as: T.self)
        }
        offset += T.byteWidth

        return value
    }
}

struct Fields32 {
    var flags: UInt32 = 0
    var data: Data
    var offset = 0

    init(_ data: Data) {
        self.data = data
        self.flags = get()
    }

    mutating func get<T: FixedWidthInteger>() -> T {
        let byteWidth = T.self.byteWidth
        var value: T = 0

        data.subdata(
            in: data.startIndex.advanced(by: offset)..<data.startIndex.advanced(by: offset + byteWidth)
        ).withUnsafeBytes { bytes in
            value = bytes.load(as: T.self)
        }
        offset += T.byteWidth

        return value
    }
}
