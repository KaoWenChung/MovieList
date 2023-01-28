//
//  DefaultMoviesRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//


final class DefaultMoviesRepository {
    private let dataTransferService: DataTransferServiceType

    init(dataTransferService: DataTransferServiceType) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMoviesRepository: MoviesRepositoryType {
    public func fetchMoviesList(page: Int,
                                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType? {
        let task = RepositoryTask()
        return task
    }
}
