//
//  MachineListCell.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 27.12.2024.
//

import UIKit

final class MachineListCell: UITableViewCell {
    private lazy var titleLabel = UILabel()

    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    // MARK: - Public methods
    private func update(title: String) {
        titleLabel.text = title
    }

    // MARK: - Private methods
    private func setupViews() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8.0)
            ]
        )
    }
}
