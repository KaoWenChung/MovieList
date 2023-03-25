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

    func test_executeLogoutUseCase_logoutSuccessfullyAndSwitchToLoginView() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        var didSwitchToLoginView: Bool = false
        let didLogoutMock = {
            didSwitchToLoginView.toggle()
        }
        let logoutUseCaseMockMock = LogoutUseCaseMock()
        logoutUseCaseMockMock.expectation = expectation(description: "logout successfully")
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(),
                                     fetchMoviesUseCase: fetchMoviesUseCaseMock,
                                     actions: MovieListViewModelActions(didLogout: didLogoutMock),
                                     logoutUseCase: logoutUseCaseMockMock)
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
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(),
                                     fetchMoviesUseCase: fetchMoviesUseCaseMock,
                                     actions: MovieListViewModelActions(didLogout: didLogoutMock),
                                     logoutUseCase: LogoutUseCaseMock())
        // when
        sut.viewDidLoad()
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.movieList.value.count, 3)
    }

    func test_fetchMoviesUseCaseFetchDataFailed_viewModelContainsFailedLoadingMoviesError() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        fetchMoviesUseCaseMock.expectation = self.expectation(description: "contains failed error")
        fetchMoviesUseCaseMock.error = MovieListViewModelTestError.failedFetching
        let didLogoutMock = {}
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(),
                                     fetchMoviesUseCase: fetchMoviesUseCaseMock,
                                     actions: MovieListViewModelActions(didLogout: didLogoutMock),
                                     logoutUseCase: LogoutUseCaseMock())
        // when
        sut.viewDidLoad()
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.error.value, "Failed loading movies")
    }

    func test_loadNextPageSuccessfully_viewModelContains6Movies() {
        // given
        let fetchMoviesUseCaseMock = FetchMoviesUseCaseMock()
        let expectation = self.expectation(description: "contains 6 movie's value")
        expectation.expectedFulfillmentCount = 2
        fetchMoviesUseCaseMock.expectation = expectation
        fetchMoviesUseCaseMock.movieList = MovieList(totalResults: 0, movies: movies)
        let didLogoutMock = {}
        let sut = MovieListViewModel(imageRepository: ImageRepositoryMock(),
                                     fetchMoviesUseCase: fetchMoviesUseCaseMock,
                                     actions: MovieListViewModelActions(didLogout: didLogoutMock),
                                     logoutUseCase: LogoutUseCaseMock())
        // when
        sut.viewDidLoad()
        sut.loadNextPage()
        // then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(sut.movieList.value.count, 6)
    }
}
