//
//  DataTransferService.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public final class DataTransferService {
    private let networkService: NetworkServiceType
    private let errorResolver: DataTransferErrorResolverType
    private let errorLogger: DataTransferErrorLoggerType

    public init(networkService: NetworkServiceType,
                errorResolver: DataTransferErrorResolverType = DefaultDataTransferErrorResolver(),
                errorLogger: DataTransferErrorLoggerType = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DataTransferService: DataTransferServiceType {
    public func request<T: Decodable, E: ResponseRequestableType>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>) -> NetworkCancellableType? where E.Response == T {

        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                completion(result)
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoderType) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }

    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}

// MARK: - Logger
public final class DefaultDataTransferErrorLogger: DataTransferErrorLoggerType {
    public init() { }

    public func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}

// MARK: - Error Resolver
public class DefaultDataTransferErrorResolver: DataTransferErrorResolverType {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoderType {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoderType {
    public init() { }

    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default],
                                                debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
