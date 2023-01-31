//
//  MoviesRepositoryType.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

protocol MoviesRepositoryType {
    @discardableResult
    func fetchMoviesList(request: SearchMoviesRequestValue,
                         completion: @escaping (Result<MovieList, Error>) -> Void) -> CancellableType?
}

