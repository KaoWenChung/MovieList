//
//  APIEndpoints.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

struct APIEndpoints {
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {
        return Endpoint(path: "",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }
}
