//
//  UITableViewTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/3/27.
//

import XCTest
@testable import MovieList

final class UITableViewTests: XCTestCase {
    private class MockCell: UITableViewCell {}
    func testRegisterCell() {
        // given
        let tableView = UITableView()
        // when
        tableView.register(MockCell.self)
        // then
        let cell = tableView.dequeueReusableCell(withIdentifier: MockCell.name)
        XCTAssertNotNil(cell)
    }
}
