//
//  MovieListViewControllerTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/2/10.
//

import XCTest
@testable import MovieList

final class MovieListViewControllerTests: XCTestCase {
    func testIsMemoryLeaks() throws {
        assertDeallocation { () -> UIViewController in
            let viewModel = MovieListViewModel(imageRepository: ImageRepositoryMock(),
                                               fetchMoviesUseCase: FetchMoviesUseCaseMock(),
                                               actions: MovieListViewModelActions(didLogout: {}),
                                               logoutUseCase: LogoutUseCaseMock())
            let sut = MovieListViewController(viewModel: viewModel)
            return sut
        }
    }
}
