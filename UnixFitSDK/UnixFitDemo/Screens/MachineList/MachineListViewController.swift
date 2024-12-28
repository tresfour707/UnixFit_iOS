//
//  MachineListViewController.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import UIKit

final class MachineListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}

extension MachineListViewController: UITableViewDelegate, UITableViewDataSource {

}
