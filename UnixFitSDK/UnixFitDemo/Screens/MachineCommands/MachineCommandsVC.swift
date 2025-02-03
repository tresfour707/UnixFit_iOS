//
//  MachineCommandsVC.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import Foundation
import UIKit
import UnixFitSDK

final class MachineCommandsVC: UIViewController {
    private lazy var trainingStatusLabel = UILabel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(MachineListCell.self)
        tableView.register(OneButtonCell.self)
        tableView.register(TwoButtonsCell.self)

        return tableView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12

        stackView.addArrangedSubview(trainingStatusLabel)
        stackView.addArrangedSubview(tableView)

        return stackView
    }()

    var activeSessionManager: SessionManaging!

    var logs = [String]()

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"

        return formatter
    }()

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
        trainingStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )

        setTrainingStatus(activeSessionManager.currentTrainingStatus?.statusType.title ?? "")
    }

    private func setTrainingStatus(_ trainingStatusString: String) {
        trainingStatusLabel.text = " Текущий статус: \(trainingStatusString)"
    }

    private func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }

    private func openDetailScreen() {
        let detailVC = MachineDetailViewController()
        detailVC.activeSessionManager = activeSessionManager

        present(detailVC, animated: true)
    }

    private func openStatusesScreen() {
        let statusesScreen = MachineStatusVC()
        statusesScreen.logs = logs.reversed()
        navigationController?.pushViewController(statusesScreen, animated: true)
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
            inputVC.update(with: ["timeInFatBurnZone (1s)", "timeInFitnessZone (1s)"]) { [weak self] values in
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
            inputVC.update(with: ["timeInLightZone (1s)", "timeInModerateZone (1s)", "timeInHardZone (1s)"]) { [weak self] values in
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
                    "timeInVeryLightZone (1s)",
                    "timeInLightZone (1s)",
                    "timeInModerateZone (1s)",
                    "timeInHardZone (1s)",
                    "timeInMaximumZone (1s)"
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
                    "windSpeed (0.001 m/s)",
                    "grade (0.1 %)",
                    "crr (0.0001)",
                    "cw (0.01)"
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

        navigationController?.pushViewController(inputVC, animated: true)
    }

    private func saveToLogs(_ log: String) {
        let dateString = dateFormatter.string(from: Date())
        logs.append(dateString + ": " + log)
    }
}

extension MachineCommandsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        MachineCommandsSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = MachineCommandsSectionType.allCases[section]

        switch sectionType {
        case .detailInformation, .statuses:
            return 1

        case .commands:
            return CommandType.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = MachineCommandsSectionType.allCases[indexPath.section]

        switch sectionType {
        case .detailInformation:
            let cell = tableView.dequeueCell(withType: MachineListCell.self, for: indexPath)
            cell.update(title: "Detail information")
            return cell

        case .statuses:
            let cell = tableView.dequeueCell(withType: MachineListCell.self, for: indexPath)
            cell.update(title: "Logs")
            return cell

        default:
            break
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
            let cell = tableView.dequeueCell(withType: TwoButtonsCell.self, for: indexPath)
            cell.update(
                firstButtonTitle: "Start SpinDown",
                secondButtonTitle: "Ignore",
                onFirstButtonTouched: { [weak self] in
                    self?.activeSessionManager.send(commandWithValue: .spinDownControl(.start))
                }, onSecondButtonTouched: { [weak self] in
                    self?.activeSessionManager.send(commandWithValue: .spinDownControl(.ignore))
                })

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

        let sectionType = MachineCommandsSectionType.allCases[indexPath.section]

        switch sectionType {
        case .detailInformation:
            openDetailScreen()

        case .statuses:
            openStatusesScreen()

        case .commands:
            let commandType = CommandType.allCases[indexPath.row]

            switch commandType {
            case .requestControl, .reset, .stopOrPause, .startOrResume, .spinDownControl:
                return

            default:
                openInputScreen(for: commandType)
            }
        }
    }
}

extension MachineCommandsVC: SessionManagerDelegate {
    func sessionManagerDidRecieveFTMSStatus(_ ftmsStatus: UnixFitSDK.FTMSStatus) {
        let ftmsStatus = "FTMS Status: \(ftmsStatus)"
        saveToLogs(ftmsStatus)
    }
    
    func sessionManagerDidCompleteCommand(commandResponse: UnixFitSDK.CommandResponseData) {
        guard let resultCode = commandResponse.resultCode, let requestCommand = commandResponse.requestCommand else {
            return
        }
        let commandResponse = "Command Response: \(requestCommand) command result: \(resultCode)"
        saveToLogs(commandResponse)
    }
    
    func sessionManagerDidChangeTrainingStatus(_ trainingStatus: UnixFitSDK.TrainingStatusData) {
        let trainingStatusString = "Training Status: \(trainingStatus.statusType.title)"
        saveToLogs(trainingStatusString)
        setTrainingStatus(trainingStatus.statusType.title)
    }

    func sessionManagerDidFetchFTMSFeatures(_ features: FTMSFeaturesData) {
        let featuresString = "FTMSFeatures: \(features)"
        saveToLogs(featuresString)
    }

    func sessionManagerDidRecieveSupportedSpeedRange(_ supportedSpeedRange: SupportedSpeedRange) {
        let speedRangeString = "Supported Speed Range: \(supportedSpeedRange)"
        saveToLogs(speedRangeString)
    }

    func sessionManagerDidRecieveSupportedPowerRange(_ supportedPowerRange: SupportedPowerRange) {
        let powerRangeString = "Supported Power Range: \(supportedPowerRange)"
        saveToLogs(powerRangeString)
    }

    func sessionManagerDidRecieveSupportedInclinationRange(_ supportedInclinationRange: SupportedInclinationRange) {
        let inclinationRangeString = "Supported Inclination Range: \(supportedInclinationRange)"
        saveToLogs(inclinationRangeString)
    }

    func sessionManagerDidRecieveSupportedHeartRateRange(_ supportedHeartRate: SupportedHeartRateRange) {
        let heartRateRangeString = "Supported Heart Rate Range: \(supportedHeartRate)"
        saveToLogs(heartRateRangeString)
    }

    func sessionManagerDidRecieveSupportedResistanceLevelRange(_ supportedResistanceLevelRange: SupportedResistanceLevelRange) {
        let resistanceLevelRangeString = "Supported Resistance Level Range: \(supportedResistanceLevelRange)"
        saveToLogs(resistanceLevelRangeString)
    }
}

enum MachineCommandsSectionType: Int, CaseIterable {
    case detailInformation = 0
    case statuses
    case commands
}
