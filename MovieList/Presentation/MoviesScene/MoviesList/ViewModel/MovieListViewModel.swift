//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

struct MovieListViewModelActions {
    let didLogout: () -> Void
}

protocol MovieListViewModelInput {
    func viewDidLoad()
    func loadNextPage()
    func didSelectLogout()
}

protocol MovieListViewModelOutput {
    var movieList: Observable<[MovieListCellViewModel]> { get }
    var status: Observable<LoadingStatus> { get }
    var error: Observable<String> { get }
    var errorTitle: String { get }
}

protocol MovieListViewModelType: MovieListViewModelInput, MovieListViewModelOutput {}

final class MovieListViewModel {
    // MARK: Predefined value
    enum Content {
        static let defaultSearch = "love"
        static let defaultYear = 2000
        static let defaultTotalResult = 0
        static let defaultPage = 1
        static let aYear = 1
        static let aPage = 1
    }
    // MARK: Repository
    private let imageRepository: ImageRepositoryType

    // MARK: UseCase
    private let fetchMoviesUseCase: FetchMoviesUseCaseType
    private let logoutUseCase: LogoutUseCaseType

    // MARK: Actions
    private let actions: MovieListViewModelActions?

    // MARK: Properties
    private var moviesLoadTask: CancellableType? { willSet { moviesLoadTask?.cancel() } }
    private var currentSearchYear = Content.defaultYear
    /// The amount til the current search page
    private var currentSearchTotalResult = Content.defaultTotalResult
    private var currentPage: Int = Content.defaultPage
    /// The total amount of movie result
    private var totalResults: Int = Content.defaultTotalResult
    private var hasMorePages: Bool { movieList.value.count < totalResults }
    private var nextPage: Int { hasMorePages ? currentPage + Content.aPage : currentPage }

    // MARK: Output
    let error: Observable<String> = Observable("")
    let movieList: Observable<[MovieListCellViewModel]> = Observable([])
    let status: Observable<LoadingStatus> = Observable(.normal)
    private(set) var errorTitle: String = CommonString.error.text

    init(imageRepository: ImageRepositoryType,
         fetchMoviesUseCase: FetchMoviesUseCaseType,
         actions: MovieListViewModelActions,
         logoutUseCase: LogoutUseCaseType) {
        self.imageRepository = imageRepository
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.actions = actions
        self.logoutUseCase = logoutUseCase
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        ErrorString.noInternet.text : ErrorString.failLoadingMovies.text
    }

    private func appendPage(_ page: MovieList) {
        totalResults = page.totalResults
        currentPage += Content.aPage
        currentSearchTotalResult += page.movies.count

        movieList.value.append(contentsOf: page.movies.map {
            MovieListCellViewModel.init($0, imageRepository: imageRepository)
        })
    }

    private func loadMovies() {
        guard status.value == .normal else { return }
        status.value = .loading
        let request = FetchMoviesRequestValue(search: Content.defaultSearch,
                                              year: currentSearchYear.description,
                                              page: currentPage)
        moviesLoadTask = fetchMoviesUseCase.execute(requestValue: request) { result in
            switch result {
            case .success(let page):
                self.appendPage(page)
            case .failure(let error):
                self.handle(error: error)
            }
            self.status.value = .normal
        }
    }

    private func checkSouldSearchNextYear() {
        /* Check the current result amount is already equal to the total number of the total amount of the specific year
         */
        guard currentSearchTotalResult == totalResults else { return }
        guard let currentYear = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year,
              currentSearchYear < currentYear else { return }
        // set next year
        currentSearchYear += Content.aYear
        // reset the condition of search amount
        currentSearchTotalResult = Content.defaultTotalResult
        currentPage = Content.defaultPage
    }
}

extension MovieListViewModel: MovieListViewModelType {
    func didSelectLogout() {
        logoutUseCase.execute()
        actions?.didLogout()
    }

    func loadNextPage() {
        checkSouldSearchNextYear()
        loadMovies()
    }

    func viewDidLoad() {
        loadMovies()
    }
}
