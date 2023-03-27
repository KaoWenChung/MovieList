//
//  UITableView+.swift
//  MovieList
//
//  Created by wyn on 2023/3/27.
//

import UIKit

extension UITableView {
    public func register(_ cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.name, bundle: nil), forCellReuseIdentifier: cell.name)
    }

    public func dequeueCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.name, for: indexPath) as? T
        return cell ?? T()
    }
}
