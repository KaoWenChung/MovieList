//
//  UITableViewTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/3/27.
//

import XCTest
@testable import MovieList

final class UITableViewTests: XCTestCase {
    func test_registerCell_dequeueCellSuccessfully() {
        // given
        let tableView = UITableView()
        // when
        tableView.register(MovieListTableViewCell.self)
        // then
        let registeredCell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.name)
        XCTAssertNotNil(registeredCell, "Failed to register cell type")
    }

    func test_noRegisterCell_nil() {
        // given
        let tableView = UITableView()
        // then
        let registeredCell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.name)
        XCTAssertNil(registeredCell, "Failed to register cell type")
    }

    func test_dequeueCell_dequeueCellSuccessfully() {
        // given
        let tableView = UITableView()
        // when
        tableView.register(UINib(nibName: MovieListTableViewCell.name,
                                 bundle: nil),
                           forCellReuseIdentifier: MovieListTableViewCell.name)
        // then
        let registeredCell: MovieListTableViewCell? = tableView.dequeueCell(IndexPath())
        XCTAssertNotNil(registeredCell, "Failed to register cell type")
    }
}
