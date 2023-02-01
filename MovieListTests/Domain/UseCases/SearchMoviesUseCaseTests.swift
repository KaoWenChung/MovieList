//
//  SearchMoviesUseCaseTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/31.
//

import XCTest
@testable import MovieList

final class SearchMoviesUseCaseTests: XCTestCase {
    let movies = [Movie.stub(title:"title0"), Movie.stub(title: "title1"), Movie.stub(title: "title2")]
    enum MoviesRepositorySuccessTestError: Error {
        case failedFetching
    }
    
    struct MoviesRepositoryMock: MoviesRepositoryType {
        let result: Result<MovieList, Error>
        init(result: Result<MovieList, Error>) {
            self.result = result
        }
        func fetchMoviesList(request: FetchMoviesRequestValue, completion: @escaping (Result<MovieList, Error>) -> Void) -> CancellableType? {
            completion(result)
            return nil
        }
    }
    func testSearchMoviesUseCase_successfullyFetchesMovies() {
        // give
        let expectation = self.expectation(description: "Fetch data successfully")
        expectation.expectedFulfillmentCount = 2
        let repository = MoviesRepositoryMock(result: .success(MovieList(totalResults: 3, movies: movies)))
        let sut = FetchMoviesUseCase(moviesRepository: repository)
        
        // when
        let requestValue = FetchMoviesRequestValue(search: "love", year: "2000", page: 1)
        var useCaseResult: MovieList?
        _ = sut.execute(requestValue: requestValue, completion: { result in
            useCaseResult = try? result.get()
            expectation.fulfill()
        })
        var repositoryResult: MovieList?
        _ = repository.fetchMoviesList(request: requestValue, completion: { result in
            repositoryResult = try? result.get()
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(useCaseResult?.totalResults, 3)
        XCTAssertEqual(useCaseResult?.movies.first?.title, "title0")
        
        XCTAssertEqual(repositoryResult?.totalResults, 3)
        XCTAssertEqual(repositoryResult?.movies.first?.title, "title0")
    }

    func testSearchMoviesUseCase_failedFetchingMovies() {
        // give
        let expectation = self.expectation(description: "Fetch data failed")
        expectation.expectedFulfillmentCount = 2
        let repository = MoviesRepositoryMock(result: .failure(MoviesRepositorySuccessTestError.failedFetching))
        let sut = FetchMoviesUseCase(moviesRepository: repository)
        
        // when
        let requestValue = FetchMoviesRequestValue(search: "love", year: "2000", page: 1)
        var useCaseResult: MovieList?
        _ = sut.execute(requestValue: requestValue, completion: { result in
            do {
                useCaseResult = try result.get()
            } catch {
                expectation.fulfill()
            }
        })
        var repositoryResult: MovieList?
        _ = repository.fetchMoviesList(request: requestValue, completion: { result in
            do {
                repositoryResult = try result.get()
            } catch {
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(useCaseResult)
        XCTAssertNil(repositoryResult)
    }
}
