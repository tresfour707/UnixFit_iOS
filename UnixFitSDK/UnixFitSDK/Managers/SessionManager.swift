//
//  SessionManager.swift
//  UnixFitSDK
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import CoreBluetooth

public protocol SessionManaging: AnyObject {
    var peripheralModel: PeripheralModel { get }

    func addDelegate(_ delegate: SessionManagerDelegate)
    func removeDelegate(_ delegate: SessionManagerDelegate)
    func send(commandWithValue: CommandWithValue)
}

class SessionManager: NSObject, SessionManaging {
    public let peripheralModel: PeripheralModel
    fileprivate var controlCharacteristic: CBCharacteristic?

    var multicastDelegate = MulticastDelegate<SessionManagerDelegate>()

    init(peripheralModel: PeripheralModel) {
        self.peripheralModel = peripheralModel
        super.init()
        peripheralModel.peripheral.delegate = self
        peripheralModel.peripheral.discoverServices([FTMSCharacteristic.serviceFTMS.uuid])
    }

    // MARK: - Public methods
    public func addDelegate(_ delegate: SessionManagerDelegate) {
        multicastDelegate.add(delegate: delegate)
    }

    public func removeDelegate(_ delegate: SessionManagerDelegate) {
        multicastDelegate.remove(delegate: delegate)
    }

    public func send(commandWithValue: CommandWithValue) {
        guard let controlCharacteristic else {
            return
        }
        let command = commandWithValue.createCommand()
        peripheralModel.peripheral.writeValue(command.data, for: controlCharacteristic, type: .withResponse)
    }

    // MARK: - Internal methods
    func save(controlCharacteristic: CBCharacteristic) {
        self.controlCharacteristic = controlCharacteristic
    }

    func fetch(deviceData: DeviceData) {
        multicastDelegate.invoke { $0.sessionManagerDidFetchDeviceData(deviceData) }
    }

    func sendTrainingStatus(_ status: TrainingStatusData) {
        multicastDelegate.invoke { $0.sessionManagerDidChangeTrainingStatus(status) }
    }

    func parseFTMSFeature(_ characteristic: CBCharacteristic) {
        guard let value = characteristic.value else { return }
        let supportedCommands = SupportedCommandsData(from: value)
        print(supportedCommands)
    }
}
