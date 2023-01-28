//
//  MoviesSearchRequestDTO.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct MoviesSearchRequestDTO: Encodable {
    let apikey: String
    let search: String
    let year: String
    let page: Int
    enum CodingKeys: String, CodingKey {
        case apikey
        case search = "s"
        case year = "y"
        case page
    }
}
