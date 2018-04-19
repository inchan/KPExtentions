//
//  UITableVIew.swift
//  KPExtentions
//
//  Created by mg_kanginchan on 2018. 4. 13..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import Foundation
import UIKit

/// UI
extension UITableView {

    /// ReloadData whit completion block
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

/// Register Cell
extension UITableView {
    /// SwifterSwift: Register UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    ///
    public func registerCell<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    /// SwifterSwift: Register UITableViewCell using nib name
    ///
    /// - Parameter name: UITableViewCell type
    ///
    public func registerCell<T: UITableViewCell>(cellWithNib className: T.Type) {
        let bundle = Bundle(for: T.self)
        let nibName = String(describing: className)
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: nibName)
    }
    
    /// Register Register UITableViewCell using class names
    ///
    /// - Parameter name: UITableViewCell type in Array
    ///
    public func registerCells<T: UITableViewCell>(types: [T.Type]) {
        types.forEach { registerCell(cellWithNib: $0) }
    }

    /// 스위프터스위프트를 참고함.
    /// SwifterSwift: Dequeue reusable UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name (optional value)
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as? T
    }
    
    /// 스위프터스위프트를 참고함.
    /// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T
    }
}
