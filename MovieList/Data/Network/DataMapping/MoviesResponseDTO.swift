//
//  Movie.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct MoviesResponseDTO: Decodable {
    let response: String
    let search: [SearchDTO]
    let totalResults: String
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case search = "Search"
        case totalResults
    }
}

extension MoviesResponseDTO {
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

extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        MoviesPage(totalResults: Int(totalResults) ?? 0,
                   movies: search.map { $0.toDomain()})
    }
}

extension MoviesResponseDTO.SearchDTO {
    func toDomain() -> Movie {
        Movie(title: title, year: year, poster: poster)
    }
}
