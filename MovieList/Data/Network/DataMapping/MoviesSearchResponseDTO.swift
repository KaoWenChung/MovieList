//
//  Movie.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct MoviesSearchResponseDTO: Decodable {
    let response: Bool?
    let search: [SearchDTO]?
    let totalResults: String?
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case search = "Search"
        case totalResults
    }
}

extension MoviesSearchResponseDTO {
    struct SearchDTO: Decodable {
        let poster: String?
        let title: String?
        let type: String?
        let year: String?
        let imdbID: String?
        
        enum CodingKeys: String, CodingKey {
            case poster = "Poster"
            case title = "Title"
            case type = "Type"
            case year = "Year"
            case imdbID
        }
    }
}
