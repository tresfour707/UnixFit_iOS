//
//  AlertHelper.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 13.01.2025.
//

import Foundation
import UIKit

final class AlertHelper {
    func createAlert(title: String, message: String? = nil) -> UIAlertController {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(.init(title: "OK", style: .default))

        return alertViewController
    }
}
