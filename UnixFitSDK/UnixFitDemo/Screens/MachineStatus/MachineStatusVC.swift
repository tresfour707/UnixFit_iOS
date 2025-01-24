//
//  MachineStatusVC.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 22.01.2025.
//

import UIKit

final class MachineStatusVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(MachineListCell.self)

        return tableView
    }()

    var logs = [String]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Logs"
        view.backgroundColor = .white
        setupViews()
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

        let reverseButton = UIBarButtonItem(
            title: "Reverse",
            style: .plain,
            target: self,
            action: #selector(reverseLog)
        )

        let shareButton = UIBarButtonItem(
            title: "Share",
            style: .plain,
            target: self,
            action: #selector(shareLog)
        )
        navigationItem.rightBarButtonItems = [reverseButton, shareButton]
    }

    // MARK: - Actions
    @objc func reverseLog() {
        logs.reverse()
        tableView.reloadData()
    }

    @objc func shareLog() {
        let items = [logs.joined(separator: "\n")]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true)
    }
}

extension MachineStatusVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let status = logs[indexPath.row]
        let cell = tableView.dequeueCell(withType: MachineListCell.self, for: indexPath)
        cell.titleLabel.numberOfLines = 0
        cell.update(title: status)

        return cell
    }
}

