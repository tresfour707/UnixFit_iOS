//
//  MachineDetailViewController.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 14.01.2025.
//

import UIKit
import UnixFitSDK

final class MachineDetailViewController: UIViewController {
    var activeSessionManager: SessionManaging!
    lazy var dataLabel = UILabel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Device Detail Info"
        activeSessionManager.addDelegate(self)
        setupViews()
    }

    deinit {
        activeSessionManager.removeDelegate(self)
    }

    private func setupViews() {
        view.backgroundColor = .white
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.numberOfLines = 0
        view.addSubview(dataLabel)
        NSLayoutConstraint.activate(
            [
                dataLabel.topAnchor.constraint(equalTo: view.topAnchor),
                dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                dataLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}

extension MachineDetailViewController: SessionManagerDelegate {
    func sessionManagerDidChangeTrainingStatus(_ trainingStatus: UnixFitSDK.TrainingStatusData) {
        print(trainingStatus)
    }
    
    func sessionManagerDidFetchDeviceData(_ deviceData: DeviceData) {
        let dataString: String = {
            switch deviceData {
            case .crossTrainer(let crossTrainerRawData):
                return DeviceDataToStringConverter.convertFromCrossTrainerData(crossTrainerRawData)

            case .indoorBike(let indoorBikeRawData):
                return DeviceDataToStringConverter.convertFromIndoorBikeData(indoorBikeRawData)

            case .rower(let rowerRawData):
                return DeviceDataToStringConverter.convertFromRowerData(rowerRawData)

            case .stairClimber(let stairClimberRawData):
                return DeviceDataToStringConverter.convertFromStairClimberData(stairClimberRawData)

            case .stepClimber(let stepClimberRawData):
                return DeviceDataToStringConverter.convertFromStepClimberData(stepClimberRawData)

            case .treadmill(let treadmillRawData):
                return DeviceDataToStringConverter.convertFromTreadmillData(treadmillRawData)

            @unknown default:
                return "Unknown device"
            }
        }()

        DispatchQueue.main.async {
            self.dataLabel.text = dataString
        }
    }
}
