//
//  MachineInputVC.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import UIKit

final class MachineInputVC: UIViewController {
    private lazy var stackView: UIStackView = {
        inputsStackView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(inputsStackView)
        stackView.addArrangedSubview(sendButton)

        return stackView
    }()

    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16

        return stackView
    }()

    private lazy var sendButton = UIButton(type: .custom)

    private var completion: (([Int]) -> Void)?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    // MARK: - Public methods
    func update(with titles: [String], completion: (([Int]) -> Void)?) {
        for title in titles {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = title
            textField.keyboardType = .numberPad

            NSLayoutConstraint.activate(
                [
                    textField.heightAnchor.constraint(equalToConstant: 40.0)
                ]
            )

            inputsStackView.addArrangedSubview(textField)
        }
        self.completion = completion
    }

    // MARK: - Private methods
    private func setupViews() {
        view.addSubview(stackView)

        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                sendButton.heightAnchor.constraint(equalToConstant: 40.0)
            ]
        )

        sendButton.backgroundColor = .blue
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(didButtonTouched), for: .touchUpInside)
    }

    // MARK: - Action
    @objc private func didButtonTouched() {
        var numbers = [Int]()
        for view in inputsStackView.arrangedSubviews {
            if let textField = view as? UITextField {
                numbers.append(textField.text.flatMap { Int($0) } ?? 0)
            }
        }

        completion?(numbers)
    }
}
