//
//  LogoutUseCaseMock.swift
//  MovieListTests
//
//  Created by wyn on 2023/2/10.
//

import XCTest
@testable import MovieList

final class LogoutUseCaseMock: LogoutUseCaseType {
    var expectation: XCTestExpectation?
    var isLogout: Bool = false

    func execute() {
        isLogout.toggle()
        expectation?.fulfill()
    }
}
