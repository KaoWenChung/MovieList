//
//  SearchMoviesUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

protocol SearchMoviesUseCaseType {
    func execute(requestValue: SearchMoviesRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType?
}

struct SearchMoviesUseCase: SearchMoviesUseCaseType {
    private let moviesRepository: MoviesRepositoryType

    init(moviesRepository: MoviesRepositoryType) {
        self.moviesRepository = moviesRepository
    }

    func execute(requestValue: SearchMoviesRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType? {
        return moviesRepository.fetchMoviesList(request: requestValue, completion: completion)
    }
}

struct SearchMoviesRequestValue {
    let search: String
    let year: String
    let page: Int
}
