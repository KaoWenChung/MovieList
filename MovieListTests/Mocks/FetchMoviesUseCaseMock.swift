//
//  FetchMoviesUseCaseMock.swift
//  MovieListTests
//
//  Created by wyn on 2023/2/10.
//

import XCTest
@testable import MovieList

final class FetchMoviesUseCaseMock: FetchMoviesUseCaseType {
    var expectation: XCTestExpectation?
    var error: Error?
    var movieList = MovieList(totalResults: 0, movies: [])
    func execute(requestValue: FetchMoviesRequestValue, completion: @escaping (Result<MovieList, Error>) -> Void) -> CancellableType? {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(movieList))
        }
        expectation?.fulfill()
        return nil
    }
}
