//
//  TwoButtonsCell.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import UIKit

final class TwoButtonsCell: UITableViewCell {
    static let identifier = String(describing: type(of: TwoButtonsCell.self))

    private lazy var firstButton = UIButton(type: .custom)
    private lazy var secondButton = UIButton(type: .custom)

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)

        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 16.0

        return stackView
    }()

    private var onFirstButtonTouched: (() -> Void)?
    private var onSecondButtonTouched: (() -> Void)?

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
    func update(
        firstButtonTitle: String,
        secondButtonTitle: String,
        onFirstButtonTouched: (() -> Void)?,
        onSecondButtonTouched: (() -> Void)?
    ) {
        firstButton.setTitle(firstButtonTitle, for: .normal)
        secondButton.setTitle(secondButtonTitle, for: .normal)
        self.onFirstButtonTouched = onFirstButtonTouched
        self.onSecondButtonTouched = onSecondButtonTouched
    }

    // MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
                stackView.heightAnchor.constraint(equalToConstant: 40.0)
            ]
        )

        firstButton.backgroundColor = .blue
        secondButton.backgroundColor = .blue
        firstButton.addTarget(self, action: #selector(firstButtonTouched), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTouched), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc func firstButtonTouched() {
        onFirstButtonTouched?()
    }

    @objc func secondButtonTouched() {
        onSecondButtonTouched?()
    }
}
