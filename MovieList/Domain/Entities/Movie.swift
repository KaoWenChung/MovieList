//
//  Movie.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct Movie {
    let title: String?
    let releaseYear: String?
}

struct MoviesPage {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}
