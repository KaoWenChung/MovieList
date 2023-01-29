//
//  APIEndpoints.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

struct APIEndpoints {
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {
        return Endpoint(path: "",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }

    static func getImage(path: String) -> Endpoint<Data> {
        return Endpoint(path: path,
                        isFullPath: true,
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}
