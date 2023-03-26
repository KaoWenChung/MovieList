//
//  RepositoryTask.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

class RepositoryTask: CancellableType {
    var networkTask: NetworkCancellableType?
    var isCancelled: Bool = false

    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
