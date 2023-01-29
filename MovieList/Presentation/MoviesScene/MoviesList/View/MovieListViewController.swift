//
//  MovieListViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import UIKit

final class MovieListViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    private let viewModel: MovieListViewModelType
    init(viewModel: MovieListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        tableView.register(UINib(nibName: MovieListTableViewCell.name, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.name)
    }
    private func bind(to viewModel: MovieListViewModelType) {
        viewModel.movieList.observe(on: self) { [weak self] _ in self?.updateItems() }
    }

    private func updateItems() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.name, for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        cell.fill(viewModel.movieList.value[indexPath.row])
        if indexPath.row == viewModel.movieList.value.count - 1 {
            viewModel.loadNextPage()
        }
        return cell
    }
}
