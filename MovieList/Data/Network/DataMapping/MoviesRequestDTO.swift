//
//  MoviesSearchRequestDTO.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct MoviesRequestDTO: Encodable {
    let search: String
    let year: String
    let page: Int
    enum CodingKeys: String, CodingKey {
        case search = "s"
        case year = "y"
        case page
    }
    init(requestValue: SearchMoviesRequestValue) {
        search = requestValue.search
        year = requestValue.year
        page = requestValue.page
    }
}
