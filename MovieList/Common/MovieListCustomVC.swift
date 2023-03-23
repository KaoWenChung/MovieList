//
//  MovieListCustomViewController.swift
//  MovieList
//
//  Created by wyn on 2023/3/23.
//

import UIKit

class MovieListCustomVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .systemMint
    }
}
