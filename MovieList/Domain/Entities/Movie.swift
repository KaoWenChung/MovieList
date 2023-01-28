//
//  Movie.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct Movie {
    let title: String?
    let year: String?
    let poster: String?
}

struct MoviesPage {
    let totalPages: Int
    let movies: [Movie]
}
