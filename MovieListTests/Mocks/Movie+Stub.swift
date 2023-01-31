//
//  Movie+stub.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/31.
//

@testable import MovieList

extension Movie {
    static func stub(title: String = "title1",
                     year: String? = "2000",
                     poster: String? = "https://mock.com/img1.jpg") -> Self {
        Movie(title: title, year: year, poster: poster)
    }
}
