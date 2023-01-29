//
//  MovieListCellViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

struct MovieListCellViewModel {
    let imageRepository: ImageRepositoryType
    let title: String
    let year: String
    let poster: String?
    init(_ movie: Movie, imageRepository: ImageRepositoryType) {
        self.imageRepository = imageRepository
        title = movie.title ?? ""
        year = movie.year ?? ""
        if let poster = movie.poster, poster.isValidURL {
            self.poster = poster
        } else {
            poster = nil
        }
    }
}

