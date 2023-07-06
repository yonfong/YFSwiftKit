//
//  UICollectionViewExtension.swift
//  YFSwiftKit
//
//  Created by sky on 2022/10/8.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - UICollectionViewCell
public extension UICollectionView {
    func registerCell<T:UICollectionViewCell>(_ type: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: T.self)
        register(type, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UICollectionViewCell>(for indexPath: IndexPath, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError(
                "Unable to dequeue \(T.self.description()), make sure the cell is registered with collection view")
        }
        return cell
    }
}


// MARK: - UICollectionReusableView
public extension UICollectionView {
    func registerSupplementary<T:UICollectionReusableView>(_ type: T.Type, kind: String, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: T.self)
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    func dequeueSupplementary<T:UICollectionReusableView>(kind: String, for indexPath: IndexPath,  identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError(
                "Unable to dequeue \(T.self.description()), make sure the view is registered with collection view")
        }
        return view
    }
}


#endif

