//
//  UITableView+Extensions.swift
//  UnixFitDemo
//
//  Created by Dmitriy Mamatov on 16.01.2025.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type)

        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Issue with dequeuing")
        }
        return cell
    }

    func register<T: UITableViewCell>(_ type: T.Type) {
        let identifier = String(describing: type)
        register(type.self, forCellReuseIdentifier: identifier)
    }
}
