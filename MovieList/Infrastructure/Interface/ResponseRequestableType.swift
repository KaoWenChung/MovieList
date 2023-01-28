//
//  ResponseRequestableType.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

public protocol ResponseRequestableType: RequestableType {
    associatedtype Response
    var responseDecoder: ResponseDecoderType { get }
}
