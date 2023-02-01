//
//  MovieListViewController.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import UIKit

final class MovieListViewController: UIViewController, Alertable, Loadingable {
    enum MovieListViewString: LocalizedStringType {
        case title
    }
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
        title = MovieListViewString.title.text
        bind(to: viewModel)
        viewModel.viewDidLoad()
        tableView.register(UINib(nibName: MovieListTableViewCell.name, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.name)
        initNavigationItem()
    }

    private func bind(to viewModel: MovieListViewModelType) {
        viewModel.movieList.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.status.observe(on: self) { [weak self] in self?.showSpinner($0) }
    }

    private func initNavigationItem() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
    }

    @objc private func logout() {
        viewModel.didSelectLogout()
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(style: .alert, title: viewModel.errorTitle, message: error, cancel: CommonString.ok.text)
    }

    private func showSpinner(_ status: LoadingStatus) {
        if status == .loading {
            showSpinner()
        } else {
            hideSpinner()
        }
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
        // load the next page if needed
        if indexPath.row == viewModel.movieList.value.count - 1 {
            viewModel.loadNextPage()
        }
        return cell
    }
}
