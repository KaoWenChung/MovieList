//
//  SearchMoviesUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

protocol SearchMoviesUseCaseType {
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType?
}

final class SearchMoviesUseCase: SearchMoviesUseCaseType {
    private let moviesRepository: MoviesRepositoryType

    init(moviesRepository: MoviesRepositoryType) {
        self.moviesRepository = moviesRepository
    }

    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType? {
        return moviesRepository.fetchMoviesList(page: requestValue.page,
                                                completion: { result in

            if case .success = result {
//                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }
            completion(result)
        })
    }
}

struct SearchMoviesUseCaseRequestValue {
    let year: String
    let page: Int
}
