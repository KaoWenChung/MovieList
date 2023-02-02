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
        var expectation: XCTestExpectation?
        var isLogout: Bool = false

        func execute() {
            isLogout.toggle()
            expectation?.fulfill()
        }
    }

    func test_executeLogoutUseCase_logoutSuccessfullyAndSwitchToLoginView() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        var didSwitchToLoginView: Bool = false
        let didLogoutMock = {
            didSwitchToLoginView.toggle()
        }
        let logoutUseCaseMockMock = LogoutUseCaseMock()
        logoutUseCaseMockMock.expectation = expectation(description: "logout successfully")
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(), fetchMoviesUseCase: fetchMoviesUseCaseMock, actions: MovieListViewModelActions(didLogout: didLogoutMock), logoutUseCase: logoutUseCaseMockMock)
        // when
        sut.didSelectLogout()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(logoutUseCaseMockMock.isLogout, true)
        XCTAssertEqual(didSwitchToLoginView, true)
    }
    
    func test_fetchMoviesUseCaseFetchDataSuccessfully_viewModelContains3Movies() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        fetchMoviesUseCaseMock.expectation = self.expectation(description: "contains 3 movie's value")
        fetchMoviesUseCaseMock.movieList = MovieList(totalResults: 0, movies: movies)
        let didLogoutMock = {}
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(), fetchMoviesUseCase: fetchMoviesUseCaseMock, actions: MovieListViewModelActions(didLogout: didLogoutMock), logoutUseCase: LogoutUseCaseMock())
        // when
        sut.viewDidLoad()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.movieList.value.count, 3)
    }

    func test_searchMoviesUseCaseFetchDataFailed_viewModelContainsFailedLoadingMoviesError() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        fetchMoviesUseCaseMock.expectation = self.expectation(description: "contains failed error")
        fetchMoviesUseCaseMock.error = MovieListViewModelTestError.failedFetching
        let didLogoutMock = {}
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(), fetchMoviesUseCase: fetchMoviesUseCaseMock, actions: MovieListViewModelActions(didLogout: didLogoutMock), logoutUseCase: LogoutUseCaseMock())
        // when
        sut.viewDidLoad()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.error.value, "Failed loading movies")
    }
}
