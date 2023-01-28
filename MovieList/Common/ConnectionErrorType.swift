//
//  ConnectionError.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

public protocol ConnectionErrorType: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionErrorType, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}

