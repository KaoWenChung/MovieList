//
//  MoviesRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//


struct MoviesRepository {
    private let dataTransferService: DataTransferServiceType

    init(dataTransferService: DataTransferServiceType) {
        self.dataTransferService = dataTransferService
    }
}

extension MoviesRepository: MoviesRepositoryType {
    public func fetchMoviesList(request: SearchMoviesRequestValue,
                                completion: @escaping (Result<MoviesPage, Error>) -> Void) -> CancellableType? {
        let task = RepositoryTask()
        let requestDTO = MoviesRequestDTO(requestValue: request)
        let endpoint = APIEndpoints.getMovies(with: requestDTO)
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let value):
                completion(.success(value.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
