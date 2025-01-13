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
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    var bluetoothManager: BluetoothManaging!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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

        tableView.register(MachineListCell.self, forCellReuseIdentifier: MachineListCell.identifier)

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
        tableView.reloadData()
    }
    
    func bluetoothManagerDidConnectToPeripheral(with peripheralModel: UnixFitSDK.PeripheralModel) {
        activityIndicator.stopAnimating()
        bluetoothManager.stopScanningForPeripherals()
    }
    
    func bluetoothManagerDidDisconnectPeripheral(_ peripheralModel: UnixFitSDK.PeripheralModel) {
        activityIndicator.stopAnimating()
    }
    
    func bluetoothManagerDidFailToConnectPeripheral(_ peripheralModel: UnixFitSDK.PeripheralModel, error: (any Error)?) {
        activityIndicator.stopAnimating()
    }
}

extension MachineListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bluetoothManager.peripheralModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let peripheralModel = bluetoothManager.peripheralModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MachineListCell.identifier, for: indexPath) as? MachineListCell else {
            fatalError()
        }

        cell.update(title: peripheralModel.name)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheralModel = bluetoothManager.peripheralModels[indexPath.row]
        bluetoothManager.connect(to: peripheralModel)
        activityIndicator.startAnimating()
    }
}
