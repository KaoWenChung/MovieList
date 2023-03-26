//
//  NetworkSessionManagerMock.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/29.
//

@testable import MovieList
import Foundation

struct NetworkSessionManagerMock: NetworkSessionManagerType {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellableType {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
