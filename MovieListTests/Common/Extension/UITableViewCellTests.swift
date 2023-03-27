//
//  UITableViewCellTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/31.
//

import XCTest
@testable import MovieList

final class UITableViewCellTests: XCTestCase {
    func test_nameOfMockUITableViewCell_MockUITableViewCell() {
        XCTAssertEqual(MockUITableViewCell.name, "MockUITableViewCell")
    }
}

class MockUITableViewCell: UITableViewCell {}
