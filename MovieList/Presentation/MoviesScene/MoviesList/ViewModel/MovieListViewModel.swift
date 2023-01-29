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
    func loadNextPage()
}

protocol MovieListViewModelOutput {
    var movieList: Observable<[MovieListCellViewModel]> { get }
    var error: Observable<String> { get }
    var errorTitle: String { get }
}

protocol MovieListViewModelType: MovieListViewModelInput, MovieListViewModelOutput {}

final class MovieListViewModel {
    // MARK: Predefined
    enum Content {
        static let defaultSearch = "Love"
        static let defaultYear = 2000
        static let defaultTotalResult = 0
        static let defaultPage = 1
        static let aYear = 1
        static let aPage = 1
    }
    // MARK: Repository
    private let imageRepository: ImageRepositoryType

    // MARK: UseCase
    private let searchMoviesUseCase: SearchMoviesUseCaseType
    private let actions: MovieListViewModelActions

    // MARK: Properties
    private var moviesLoadTask: CancellableType? { willSet { moviesLoadTask?.cancel() } }
    private var currentSearchYear = Content.defaultYear
    private var currentSearchTotalResult = Content.defaultTotalResult
    private var currentPage: Int = Content.defaultPage
    private var totalResults: Int = Content.defaultTotalResult
    private var hasMorePages: Bool { movieList.value.count < totalResults }
    private var nextPage: Int { hasMorePages ? currentPage + Content.aPage : currentPage }

    // MARK: Output
    let error: Observable<String> = Observable("")
    let movieList: Observable<[MovieListCellViewModel]> = Observable([])
    private(set) var errorTitle: String = ""

    init(imageRepository: ImageRepositoryType,
         searchMoviesUseCase: SearchMoviesUseCaseType,
         actions: MovieListViewModelActions) {
        self.imageRepository = imageRepository
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }

    private func handle(error: Error) {
//        self.error.value = error.isInternetConnectionError ?
//            NSLocalizedString("No internet connection", comment: "") :
//            NSLocalizedString("Failed loading movies", comment: "")
    }

    private func appendPage(_ page: MoviesPage) {
        totalResults = page.totalResults
        currentPage += Content.aPage
        currentSearchTotalResult += page.movies.count

        movieList.value.append(contentsOf: page.movies.map{ MovieListCellViewModel.init($0, imageRepository: imageRepository)})
    }
    
    private func loadMovies() {
        let request = SearchMoviesRequestValue(search: Content.defaultSearch, year: currentSearchYear.description, page: currentPage)
        moviesLoadTask = searchMoviesUseCase.execute(requestValue: request) { result in
            switch result {
            case .success(let page):
                self.appendPage(page)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }
    private func updateCurrentSearchYear() {
        guard currentSearchTotalResult == totalResults else { return }
        guard let currentYear = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year,
              currentSearchYear < currentYear else { return }
        currentSearchYear += Content.aYear
        currentSearchTotalResult = Content.defaultTotalResult
        currentPage = Content.defaultPage
    }
}

extension MovieListViewModel: MovieListViewModelType {
    func loadNextPage() {
        updateCurrentSearchYear()
        loadMovies()
    }
    
    func viewDidLoad() {
        loadMovies()
    }
}
