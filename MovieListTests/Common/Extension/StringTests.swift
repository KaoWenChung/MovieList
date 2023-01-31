//
//  StringTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/29.
//

import XCTest
@testable import MovieList

final class StringTests: XCTestCase {

    func testIsValidURL_validURL_true() {
        let sut = "https://mock.com"
        let result = sut.isValidURL
        XCTAssertEqual(result, true)
    }

    func testIsValidURL_invalidURL_false() {
        let sut = "N/A"
        let result = sut.isValidURL
        XCTAssertEqual(result, false)
    }
}
