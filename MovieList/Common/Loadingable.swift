//
//  Loadingable.swift
//  MovieList
//
//  Created by wyn on 2023/1/31.
//

import UIKit

public protocol Loadingable {}

public extension Loadingable where Self: UIViewController {
    func showSpinner() {
        DispatchQueue.main.async {
            Spinner.shared.showOn(self.view)
        }
    }

    func hideSpinner() {
        DispatchQueue.main.async {
            Spinner.shared.hide()
        }
    }
}