//
//  MachineCommandsVC.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import UIKit
import UnixFitSDK

final class MachineCommandsVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    var activeSessionManager: SessionManaging!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Commands"
        view.backgroundColor = .white
        activeSessionManager.addDelegate(self)
        setupViews()
    }

    deinit {
        activeSessionManager.removeDelegate(self)
    }

    // MARK: - Private methods
    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )

        tableView.register(MachineListCell.self)
        tableView.register(OneButtonCell.self)
        tableView.register(TwoButtonsCell.self)
    }

    private func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }

    private func openDetailScreen() {
        let detailVC = MachineDetailViewController()
        detailVC.activeSessionManager = activeSessionManager

        present(detailVC, animated: true)
    }

    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func openInputScreen(for command: CommandType) {
        let inputVC = MachineInputVC()

        switch command {
        case .setTargetSpeed:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let speed = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetSpeed(speed))
                }
            }

        case .setTargetInclination:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let inclination = values.first.map({ Int16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetInclination(inclination))
                }
            }

        case .setTargetResistance:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let resistance = values.first.map({ UInt8($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetResistance(resistance))
                }
            }

        case .setTargetPower:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let power = values.first.map({ Int16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetPower(power))
                }
            }

        case .setTargetHeartRate:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let heartRate = values.first.map({ UInt8($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetHeartRate(heartRate))
                }
            }

        case .setTargetedEnergy:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let energy = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetedEnergy(energy))
                }
            }

        case .setTargetedNumberOfSteps:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let steps = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetedNumberOfSteps(steps))
                }
            }

        case .setTargetedNumberOfStrides:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let strides = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetedNumberOfStrides(strides))
                }
            }

        case .setTargetedDistance:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let distance = values.first.map({ UInt32($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetedDistance(distance))
                }
            }

        case .setTargetedTrainingTime:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let trainingTime = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetedTrainingTime(trainingTime))
                }
            }

        case .setTargetedTimeInTwoHeartRateZones:
            inputVC.update(with: ["timeInFatBurnZone", "timeInFitnessZone"]) { [weak self] values in
                var timeInFatBurnZone = UInt16(0)
                var timeInFitnessZone = UInt16(0)
                for i in 0..<values.count {
                    switch i {
                    case 0:
                        timeInFatBurnZone = UInt16(values[i])

                    case 1:
                        timeInFitnessZone = UInt16(values[i])

                    default:
                        break
                    }
                }

                self?.activeSessionManager.send(commandWithValue: .setTargetedTimeInTwoHeartRateZones(
                    timeInFatBurnZone: timeInFatBurnZone,
                    timeInFitnessZone: timeInFitnessZone
                ))
            }

        case .setTargetedTimeInThreeHeartRateZones:
            inputVC.update(with: ["timeInLightZone", "timeInModerateZone", "timeInHardZone"]) { [weak self] values in
                var timeInLightZone = UInt16(0)
                var timeInModerateZone = UInt16(0)
                var timeInHardZone = UInt16(0)

                for i in 0..<values.count {
                    switch i {
                    case 0:
                        timeInLightZone = UInt16(values[i])

                    case 1:
                        timeInModerateZone = UInt16(values[i])

                    case 2:
                        timeInHardZone = UInt16(values[i])

                    default:
                        break
                    }
                }

                self?.activeSessionManager.send(commandWithValue: .setTargetedTimeInThreeHeartRateZones(
                    timeInLightZone: timeInLightZone,
                    timeInModerateZone: timeInModerateZone,
                    timeInHardZone: timeInHardZone
                ))
            }

        case .setTargetedTimeInFiveHeartRateZones:
            inputVC.update(
                with: [
                    "timeInVeryLightZone",
                    "timeInLightZone",
                    "timeInModerateZone",
                    "timeInHardZone",
                    "timeInMaximumZone"
                ]
            ) { [weak self] values in
                var timeInVeryLightZone = UInt16(0)
                var timeInLightZone = UInt16(0)
                var timeInModerateZone = UInt16(0)
                var timeInHardZone = UInt16(0)
                var timeInMaximumZone = UInt16(0)

                for i in 0..<values.count {
                    switch i {
                    case 0:
                        timeInVeryLightZone = UInt16(values[i])

                    case 1:
                        timeInLightZone = UInt16(values[i])

                    case 2:
                        timeInModerateZone = UInt16(values[i])

                    case 3:
                        timeInHardZone = UInt16(values[i])

                    case 4:
                        timeInMaximumZone = UInt16(values[i])

                    default:
                        break
                    }
                }

                self?.activeSessionManager.send(commandWithValue: .setTargetedTimeInFiveHeartRateZones(
                    timeInVeryLightZone: timeInVeryLightZone,
                    timeInLightZone: timeInLightZone,
                    timeInModerateZone: timeInModerateZone,
                    timeInHardZone: timeInHardZone,
                    timeInMaximumZone: timeInMaximumZone)
                )
            }
        case .setIndoorBikeSimulationParameters:
            inputVC.update(
                with: [
                    "windSpeed",
                    "grade",
                    "crr",
                    "cw"
                ]
            ) { [weak self] values in
                var windSpeed = Int16(0)
                var grade = Int16(0)
                var crr = UInt8(0)
                var cw = UInt8(0)

                for i in 0..<values.count {
                    switch i {
                    case 0:
                        windSpeed = Int16(values[i])

                    case 1:
                        grade = Int16(values[i])

                    case 2:
                        crr = UInt8(values[i])

                    case 3:
                        cw = UInt8(values[i])

                    default:
                        break
                    }
                }

                self?.activeSessionManager.send(commandWithValue: .setIndoorBikeSimulationParameters(
                    windSpeed: windSpeed,
                    grade: grade,
                    crr: crr,
                    cw: cw
                ))
            }

        case .setWheelCircumference:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let wheelCircumference = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setWheelCircumference(wheelCircumference))
                }
            }

        case .setTargetedCadence:
            inputVC.update(with: [command.title]) { [weak self] values in
                if let cadence = values.first.map({ UInt16($0) }) {
                    self?.activeSessionManager.send(commandWithValue: .setTargetedCadence(cadence))
                }
            }

        default:
            return
        }

        present(inputVC, animated: true)
    }
}

extension MachineCommandsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1

        case 1:
            return CommandType.allCases.count

        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 1 else {
            let cell = tableView.dequeueCell(withType: MachineListCell.self, for: indexPath)
            cell.update(title: "Detail information")

            return cell
        }

        let commandType = CommandType.allCases[indexPath.row]
        switch commandType {
        case .requestControl:
            let cell = tableView.dequeueCell(withType: OneButtonCell.self, for: indexPath)
            cell.update(buttonTitle: "Request Control") { [weak self] in
                self?.activeSessionManager.send(commandWithValue: .requestControl)
            }

            return cell

        case .reset:
            let cell = tableView.dequeueCell(withType: OneButtonCell.self, for: indexPath)
            cell.update(buttonTitle: "Reset") { [weak self] in
                self?.activeSessionManager.send(commandWithValue: .reset)
            }

            return cell

        case .startOrResume:
            let cell = tableView.dequeueCell(withType: OneButtonCell.self, for: indexPath)
            cell.update(buttonTitle: "Start or resume") { [weak self] in
                self?.activeSessionManager.send(commandWithValue: .startOrResume)
            }

            return cell

        case .stopOrPause:
            let cell = tableView.dequeueCell(withType: TwoButtonsCell.self, for: indexPath)
            cell.update(
                firstButtonTitle: "Pause",
                secondButtonTitle: "Stop",
                onFirstButtonTouched: { [weak self] in
                    self?.activeSessionManager.send(commandWithValue: .stopOrPause(isStop: false))
                }, onSecondButtonTouched: { [weak self] in
                    self?.activeSessionManager.send(commandWithValue: .stopOrPause(isStop: true))
                })

            return cell
        case .spinDownControl:
            let cell = tableView.dequeueCell(withType: OneButtonCell.self, for: indexPath)
            cell.update(buttonTitle: "Spin Down Control") { [weak self] in
                self?.activeSessionManager.send(commandWithValue: .spinDownControl)
            }

            return cell

        default:
            let cell = tableView.dequeueCell(withType: MachineListCell.self, for: indexPath)
            cell.update(title: commandType.title)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard indexPath.section != 0 else {
            openDetailScreen()
            return
        }

        let commandType = CommandType.allCases[indexPath.row]

        switch commandType {
        case .requestControl, .reset, .stopOrPause, .startOrResume, .spinDownControl:
            return

        default:
            openInputScreen(for: commandType)
        }
    }
}

extension MachineCommandsVC: SessionManagerDelegate {
    func sessionManagerDidFetchDeviceData(_ deviceData: UnixFitSDK.DeviceData) {
    }
    
    func sessionManagerDidChangeTrainingStatus(_ trainingStatus: UnixFitSDK.TrainingStatusData) {
        print(trainingStatus)
    }
}
