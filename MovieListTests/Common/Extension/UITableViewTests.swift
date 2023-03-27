//
//  UITableViewTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/3/27.
//

import XCTest
@testable import MovieList

final class UITableViewTests: XCTestCase {
    func testRegisterCell() {
        // given
        let tableView = UITableView()
        // when
        tableView.register(MovieListTableViewCell.self)
        // then
        let registeredCell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.name)
        XCTAssertNotNil(registeredCell, "Failed to register cell type")
    }
}
