//
//  KeychainHelper.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

final class KeychainHelper {
    private init() {}

    class func savePassword(_ password: String, account: String) {
        let passwordData = Data(password.utf8)
        save(passwordData, service: "owenkao.MovieList", account: account)
    }

    class func readPassword(account: String) -> String? {
        guard let passwordData = read(service: "owenkao.MovieList", account: account) else { return nil }
        return String(data: passwordData, encoding: .utf8)
    }

    class func removePassword(account: String) {
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrService: "movielist.com",
          kSecAttrAccount: account
        ] as CFDictionary

        SecItemDelete(query)
    }
    
    // MARK: Private functions
    private class func save(_ data: Data, service: String, account: String) {
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            print("Error: \(status)")
        }
    }

    private class func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
}
