//
//  MovieListViewModelTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/31.
//

import XCTest
@testable import MovieList

final class MovieListViewModelTests: XCTestCase {
    let movies = [Movie.stub(title:"title0"), Movie.stub(title: "title1"), Movie.stub(title: "title2")]

    enum MovieListViewModelTestError: Error {
        case failedFetching
    }

    class FetchMoviesUseCaseMock: FetchMoviesUseCaseType {
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

    class LogoutUseCaseMock: LogoutUseCaseType {
        func execute() {}
    }
    
    func test_searchMoviesUseCaseFetchDataSuccessfully_viewModelContains3Movies() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        fetchMoviesUseCaseMock.expectation = self.expectation(description: "contains 3 movie's value")
        fetchMoviesUseCaseMock.movieList = MovieList(totalResults: 0, movies: movies)
        let didLogoutMock = {}
        let viewModel = MovieListViewModel(imageRepository: ImageRepositoryMock(), fetchMoviesUseCase: fetchMoviesUseCaseMock, actions: MovieListViewModelActions(didLogout: didLogoutMock), logoutUseCase: LogoutUseCaseMock())
        // when
        viewModel.viewDidLoad()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.movieList.value.count, 3)
    }

    func test_searchMoviesUseCaseFetchDataFailed_viewModelContainsFailedLoadingMoviesError() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        fetchMoviesUseCaseMock.expectation = self.expectation(description: "contains failed error")
        fetchMoviesUseCaseMock.error = MovieListViewModelTestError.failedFetching
        let didLogoutMock = {}
        let viewModel = MovieListViewModel(imageRepository: ImageRepositoryMock(), fetchMoviesUseCase: fetchMoviesUseCaseMock, actions: MovieListViewModelActions(didLogout: didLogoutMock), logoutUseCase: LogoutUseCaseMock())
        // when
        viewModel.viewDidLoad()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.error.value, "Failed loading movies")
    }
}
