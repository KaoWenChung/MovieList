//
//  NetworkConfigurableMock.swift
//  MovieListTests
//
//  Created by wyn on 2023/1/29.
//

@testable import MovieList
import Foundation

class NetworkConfigurableMock: NetworkConfigurableType {
    var baseURL: URL? = URL(string: "https://mock.test.com")
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
