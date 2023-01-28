//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

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
    // MARK: Output
    let error: Observable<String> = Observable("")
    let movieList: Observable<[MovieListCellViewModel]> = Observable([])
    var errorTitle: String = ""
}

extension MovieListViewModel: MovieListViewModelType {
    func viewDidLoad() {
        movieList.value = [MovieListCellViewModel(title: "wow"),
                     MovieListCellViewModel(title: "www1"),
                     MovieListCellViewModel(title: "www2"),
                     MovieListCellViewModel(title: "www3")]
    }
}

struct MovieListCellViewModel {
    let title: String
    init(title: String) {
        self.title = title
    }
}
