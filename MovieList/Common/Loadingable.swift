//
//  Loadingable.swift
//  MovieList
//
//  Created by wyn on 2023/1/31.
//

import UIKit

public protocol Loadingable {}

public extension Loadingable where Self: UIViewController {
    func toggleSpinner(_ status: LoadingStatus) {
        if status == .loading {
            showSpinner()
        } else {
            hideSpinner()
        }
    }

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
