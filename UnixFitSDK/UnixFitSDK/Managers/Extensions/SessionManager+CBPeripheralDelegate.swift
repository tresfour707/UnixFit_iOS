//
//  BluetoothManager+CBPeripheralDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

extension SessionManager: CBPeripheralDelegate {

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("[CBPeripheralDelegate] did discover FTMS service", peripheral.services!)
        let service = peripheral.services![0]
        peripheral.discoverCharacteristics(nil, for: peripheral.services![0])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("[CBPeripheralDelegate] did discover FTMS characteristic", service.characteristics ?? "")

        service.characteristics?.forEach { characteristic in
            if characteristic.uuid == FTMSCharacteristic.FTMSControlPoint.uuid {
                save(controlCharacteristic: characteristic)
            }
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print("[CBPeripheralDelegate] did update value", descriptor)
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        switch characteristic.uuid {
        case FTMSCharacteristic.rowerData.uuid:
            guard let data = characteristic.value else { return }
            let rowerData = RowerRawData(from: data)

        case FTMSCharacteristic.treadmillData.uuid:
            guard let data = characteristic.value else { return }
            let treadmillData = TreadmillRawData(from: data)

        case FTMSCharacteristic.stairClimber.uuid:
            guard let data = characteristic.value else { return }
            let stairClimberData = StairClimberRawData(from: data)

        case FTMSCharacteristic.indoorBike.uuid:
            guard let data = characteristic.value else { return }
            let indoorBikeData = IndoorBikeRawData(from: data)

        case FTMSCharacteristic.stepClimber.uuid:
            guard let data = characteristic.value else { return }
            let stepClimberData = StepClimberRawData(from: data)

        case FTMSCharacteristic.crossTrainerData.uuid:
            guard let data = characteristic.value else { return }
            let crossTrainerData = CrossTrainerRawData(from: data)

        case FTMSCharacteristic.FTMSControlPoint.uuid:
            guard let data = characteristic.value else { return }
            print(String(data: data, encoding: .utf8))

        default:
            guard let data = characteristic.value else { return }
            print( "[STATUS]", characteristic.uuid, data)
            break;
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: (any Error)?) {
        print(service)
    }
}
