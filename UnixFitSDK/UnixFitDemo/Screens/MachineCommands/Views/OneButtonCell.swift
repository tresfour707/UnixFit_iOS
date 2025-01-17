//
//  StartStopPauseCell.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import UIKit

final class OneButtonCell: UITableViewCell {
    static let identifier = String(describing: type(of: OneButtonCell.self))

    private lazy var button = UIButton(type: .custom)

    private var onButtonTouched: (() -> Void)?

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
    func update(buttonTitle: String, onButtonTouched: (() -> Void)?) {
        button.setTitle(buttonTitle, for: .normal)
        self.onButtonTouched = onButtonTouched
    }

    // MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(button)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)

        NSLayoutConstraint.activate(
            [
                button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
                button.heightAnchor.constraint(equalToConstant: 40.0)
            ]
        )
    }

    // MARK: - Actions
    @objc func buttonTouched() {
        onButtonTouched?()
    }
}
