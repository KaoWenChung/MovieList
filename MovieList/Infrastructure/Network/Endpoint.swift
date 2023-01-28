//
//  Endpoint.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public class Endpoint<R>: ResponseRequestableType {
    public typealias Response = R
    
    public let path: String
    public let isFullPath: Bool
    public let method: HTTPMethod
    public let queryParametersEncodable: Encodable?
    public let queryParameters: [String: Any]
    public let responseDecoder: ResponseDecoderType
    
    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethod,
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoderType = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.responseDecoder = responseDecoder
    }
}

public protocol RequestableType {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethod { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    
    func urlRequest(with networkConfig: NetworkConfigurableType) throws -> URLRequest
}

enum RequestGenerationError: Error {
    case components
}

extension RequestableType {
    func url(with networkConfig: NetworkConfigurableType) throws -> URL {
        let baseURL = getBaseURL(networkConfig.baseURL?.absoluteString ?? "")
        let endpoint = isFullPath ? path : baseURL.appending(path)
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        let queryParameters = try queryParametersEncodable?.toDictionary() ?? queryParameters
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        networkConfig.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }

    private func getBaseURL(_ absoluteString: String) -> String {
        return absoluteString.last != "/" ? absoluteString + "/" : absoluteString
    }

    public func urlRequest(with networkConfig: NetworkConfigurableType) throws -> URLRequest {
        let url = try self.url(with: networkConfig)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
