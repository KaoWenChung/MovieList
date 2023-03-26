//
//  NetworkConfig.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

public protocol NetworkConfigurableType {
    // When we pass the full path by Endpoint, we don't need to set baseURL. For example, poster images
    var baseURL: URL? { get }
    var queryParameters: [String: String] { get }
}

public struct APIDataNetworkConfigurable: NetworkConfigurableType {
    public let baseURL: URL?
    public let queryParameters: [String: String]

    public init(baseURL: URL? = nil,
                queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.queryParameters = queryParameters
    }
}
