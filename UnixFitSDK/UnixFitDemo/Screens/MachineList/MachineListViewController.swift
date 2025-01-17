//
//  MachineListViewController.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import UIKit
import UnixFitSDK

final class MachineListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    var bluetoothManager: BluetoothManaging!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Devices"
        view.backgroundColor = .white
        setupViews()
        setupManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        if bluetoothManager.isReady {
            bluetoothManager.scanForPeripherals()
        }
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

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }

    private func setupManager() {
        bluetoothManager = BluetoothManager(delegate: self)
    }

    private func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }

    private func openCommandsScreen() {
        let commandsScreen = MachineCommandsVC()
        commandsScreen.activeSessionManager = bluetoothManager.activeSessionManager
        navigationController?.pushViewController(commandsScreen, animated: true)
    }

    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

extension MachineListViewController: BluetoothManagerDelegate {
    func bluetoothManagerDidFail(with error: UnixFitSDK.BluetoothError) {
        switch error {
        case .poweredOff:
            let alert = AlertHelper().createAlert(title: "Bluetooth выключен")
            presentAlert(alert)

        case .resetting:
            let alert = AlertHelper().createAlert(title: "Bluetooth перегружен, повторите позднее")
            presentAlert(alert)

        case .unauthorized:
            let alert = AlertHelper().createAlert(title: "Не предоставлен доступ к Bluetooth, можно исправить в настройках")
            presentAlert(alert)

        case .unsupported:
            let alert = AlertHelper().createAlert(title: "Телефон не поддерживает Bluetooth")
            presentAlert(alert)

        case .unknown:
            let alert = AlertHelper().createAlert(title: "Неизвестная ошибка")
            presentAlert(alert)

        @unknown default:
            let alert = AlertHelper().createAlert(title: "Неизвестная ошибка")
            presentAlert(alert)
        }
    }
    
    func bluetoothManagerDidReadyStateSwitched(_ isReady: Bool) {
        isReady ? bluetoothManager.scanForPeripherals() : bluetoothManager.stopScanningForPeripherals()
    }
    
    func bluetoothManagerDidDiscover(peripheralModel: UnixFitSDK.PeripheralModel) {
        reloadData()
    }
    
    func bluetoothManagerDidConnectToPeripheral(with peripheralModel: UnixFitSDK.PeripheralModel) {
        stopAnimating()
        bluetoothManager.stopScanningForPeripherals()
        reloadData()
        DispatchQueue.main.async {
            self.openCommandsScreen()
        }
    }
    
    func bluetoothManagerDidDisconnectPeripheral(_ peripheralModel: UnixFitSDK.PeripheralModel) {
        stopAnimating()
        reloadData()
    }
    
    func bluetoothManagerDidFailToConnectPeripheral(_ peripheralModel: UnixFitSDK.PeripheralModel, error: (any Error)?) {
        stopAnimating()
        reloadData()
    }
}

extension MachineListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bluetoothManager.peripheralModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let peripheralModel = bluetoothManager.peripheralModels[indexPath.row]
        let cell = tableView.dequeueCell(withType: MachineListCell.self, for: indexPath)
        if peripheralModel.id == bluetoothManager.activeSessionManager?.peripheralModel.id {
            cell.backgroundColor = .green
        }
        cell.update(title: peripheralModel.name)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheralModel = bluetoothManager.peripheralModels[indexPath.row]

        if peripheralModel.id == bluetoothManager.activeSessionManager?.peripheralModel.id {
            openCommandsScreen()
        } else {
            if let activeSessionManager = bluetoothManager.activeSessionManager {
                bluetoothManager.disconnect(peripheralModel: activeSessionManager.peripheralModel)
            }
            bluetoothManager.connect(to: peripheralModel)
            activityIndicator.startAnimating()
        }
    }
}
