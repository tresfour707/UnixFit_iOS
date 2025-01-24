//
//  BluetoothManager+CBPeripheralDelegate.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

extension SessionManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        print("[CBPeripheralDelegate] did discover services", services)
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("[CBPeripheralDelegate] did discover FTMS characteristic", service.characteristics ?? "")

        service.characteristics?.forEach { characteristic in
            switch characteristic.uuid {
            case FTMSCharacteristic.FTMSControlPoint.uuid:
                save(controlCharacteristic: characteristic)

            default:
                peripheral.readValue(for: characteristic)
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
            fetch(deviceData: DeviceData.rower(rowerData))

        case FTMSCharacteristic.treadmillData.uuid:
            guard let data = characteristic.value else { return }
            let treadmillData = TreadmillRawData(from: data)
            fetch(deviceData: DeviceData.treadmill(treadmillData))

        case FTMSCharacteristic.stairClimber.uuid:
            guard let data = characteristic.value else { return }
            let stairClimberData = StairClimberRawData(from: data)
            fetch(deviceData: DeviceData.stairClimber(stairClimberData))

        case FTMSCharacteristic.indoorBike.uuid:
            guard let data = characteristic.value else { return }
            let indoorBikeData = IndoorBikeRawData(from: data)
            fetch(deviceData: DeviceData.indoorBike(indoorBikeData))

        case FTMSCharacteristic.stepClimber.uuid:
            guard let data = characteristic.value else { return }
            let stepClimberData = StepClimberRawData(from: data)
            fetch(deviceData: DeviceData.stepClimber(stepClimberData))

        case FTMSCharacteristic.crossTrainerData.uuid:
            guard let data = characteristic.value else { return }
            let crossTrainerData = CrossTrainerRawData(from: data)
            fetch(deviceData: DeviceData.crossTrainer(crossTrainerData))

        case FTMSCharacteristic.FTMSControlPoint.uuid:
            guard let data = characteristic.value else { return }
            let commandResponse = CommandResponseData(from: data)
            sendCommandResponse(commandResponse)

        case FTMSCharacteristic.FTMSFeature.uuid:
            guard let data = characteristic.value else { return }
            let ftmsFeaturesData = FTMSFeaturesData(from: data)
            fetch(ftmsFeaturesData: ftmsFeaturesData)

        case FTMSCharacteristic.FTMSStatus.uuid:
            guard let data = characteristic.value else { return }
            let ftmsStatus = FTMSStatus(data: data)
            sendFTMSStatus(ftmsStatus)

        case FTMSCharacteristic.trainingStatus.uuid:
            guard let data = characteristic.value else { return }
            let trainingStatus = TrainingStatusData(from: data)
            sendTrainingStatus(trainingStatus)

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
