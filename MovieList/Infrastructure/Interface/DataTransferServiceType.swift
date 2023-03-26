//
//  DataTransferServiceType.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

public protocol DataTransferServiceType {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void

    @discardableResult
    func request<T: Decodable, E: ResponseRequestableType>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) -> NetworkCancellableType? where E.Response == T
}

public protocol DataTransferErrorResolverType {
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoderType {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol DataTransferErrorLoggerType {
    func log(error: Error)
}
