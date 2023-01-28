//
//  MoviesRepositoryType.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

protocol MoviesRepositoryType {
    @discardableResult
    func fetchMoviesList(page: Int,
                         completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType?
}

