//
//  Spinner.swift
//  MovieList
//
//  Created by wyn on 2023/1/30.
//

import UIKit

final class Spinner {
    static let shared = Spinner()
    private init() {}

    private var spinner: UIActivityIndicatorView?

    func showOn(_ view: UIView) {
        hide()
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)])

        spinner.startAnimating()
        self.spinner = spinner
    }

    func hide() {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        spinner = nil
    }
}
