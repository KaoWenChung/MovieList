//
//  FetchMoviesUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

protocol FetchMoviesUseCaseType {
    func execute(requestValue: FetchMoviesRequestValue,
                 completion: @escaping (Result<MovieList, Error>) -> Void) -> CancellableType?
}

struct FetchMoviesUseCase: FetchMoviesUseCaseType {
    private let moviesRepository: MoviesRepositoryType

    init(moviesRepository: MoviesRepositoryType) {
        self.moviesRepository = moviesRepository
    }

    func execute(requestValue: FetchMoviesRequestValue,
                 completion: @escaping (Result<MovieList, Error>) -> Void) -> CancellableType? {
        return moviesRepository.fetchMoviesList(request: requestValue, completion: completion)
    }
}

struct FetchMoviesRequestValue {
    let search: String
    let year: String
    let page: Int
}
