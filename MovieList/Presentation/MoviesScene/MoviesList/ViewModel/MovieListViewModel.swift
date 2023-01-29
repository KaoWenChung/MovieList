//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

struct MovieListViewModelActions {
}

protocol MovieListViewModelInput {
    func viewDidLoad()
}

protocol MovieListViewModelOutput {
    var movieList: Observable<[MovieListCellViewModel]> { get }
    var error: Observable<String> { get }
    var errorTitle: String { get }
}

protocol MovieListViewModelType: MovieListViewModelInput, MovieListViewModelOutput {}


final class MovieListViewModel {
    // MARK: Repository
    private let imageRepository: ImageRepositoryType

    // MARK: UseCase
    private let searchMoviesUseCase: SearchMoviesUseCaseType
    private let actions: MovieListViewModelActions

    // MARK: Properties
    private var moviesLoadTask: CancellableType? { willSet { moviesLoadTask?.cancel() } }
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var hasMorePages: Bool { currentPage < totalPages }
    private var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    // MARK: Output
    let error: Observable<String> = Observable("")
    let movieList: Observable<[MovieListCellViewModel]> = Observable([])
    var errorTitle: String = ""

    init(imageRepository: ImageRepositoryType,
         searchMoviesUseCase: SearchMoviesUseCaseType,
         actions: MovieListViewModelActions) {
        self.imageRepository = imageRepository
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }

    private func appendPage(_ page: MoviesPage) {
        totalPages = page.totalPages
        currentPage += 1

        movieList.value.append(contentsOf: page.movies.map{ MovieListCellViewModel.init($0, imageRepository: imageRepository)})
    }
}

extension MovieListViewModel: MovieListViewModelType {
    func viewDidLoad() {
        moviesLoadTask = searchMoviesUseCase.execute(requestValue: .init(search: "Love", year: "2000", page: 1)) { result in
            switch result {
            case .success(let page):
                self.appendPage(page)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
}
