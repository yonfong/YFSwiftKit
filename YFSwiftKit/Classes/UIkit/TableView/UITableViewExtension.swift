//
//  UITableViewExtension.swift
//  YFSwiftKit
//
//  Created by sky on 2022/10/8.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - UITableViewCell

public extension UITableView {
    func registerCell<T:UITableViewCell>(_ type: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: T.self)
        register(type, forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(for indexPath: IndexPath, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError(
                "Unable to dequeue \(T.self.description()), make sure the cell is registered with table view")
        }
        return cell
    }
}

// MARK: - UITableViewHeaderFooterView
public extension UITableView {
    func registerHeaderFooterView<T:UITableViewHeaderFooterView>(_ type: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: T.self)
        register(type, forHeaderFooterViewReuseIdentifier: identifier)
    }
        
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError(
                "Couldn't find UITableViewHeaderFooterView for \(String(describing: T.self)), make sure the view is registered with table view")
        }
        return headerFooterView
    }
}

#endif

