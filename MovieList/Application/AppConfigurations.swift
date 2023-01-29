//
//  AppConfigurations.swift
//  MovieList
//
//  Created by wyn on 2023/1/28.
//

final class AppConfiguration {
    // Define environment
    enum Environment {
        case debug
    }

    let current: Environment
    private(set) var apiKey: String!
    private(set) var baseURL: String!
    
    init() {
        #if DEBUG
        current = .debug
        #endif
        apiKey = getAPIKey()
        baseURL = getBaseURL()
    }
    
    private func getAPIKey() -> String {
        #if DEBUG
        return <#Enter your API key here#> // TODO: ADD API KEY HERE
        #endif
    }

    private func getBaseURL() -> String {
        #if DEBUG
        return "https://www.omdbapi.com"
        #endif
    }
}

