//
//  NetworkServiceType.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

public protocol NetworkServiceType {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: RequestableType, completion: @escaping CompletionHandler) -> NetworkCancellableType?
}

public protocol NetworkSessionManagerType {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellableType
}

public protocol NetworkErrorLoggerType {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}
