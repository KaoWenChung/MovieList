//
//  UserDefaultHelper.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

final class UserDefaultHelper {
    private enum Key: String {
        case account = "owenkao.MovieList.account"
        case isSavedAccount = "owenkao.MovieList.isSavedAccount"
        case isBiometricAuthenticationOn = "owenkao.MovieList.isBiometricAuthenticationOn"
    }

    private init() {}
    static let shared = UserDefaultHelper()
    
    func removeUserData() {
        remove(.account)
        remove(.isSavedAccount)
    }

    var account: String? {
        set {
            if let account = newValue {
                save(.account, value: account)
            } else {
                remove(.account)
            }
        }
        get {
            if let account: String = read(.account) {
                return account
            } else {
                return nil
            }
        }
    }

    private func save(_ aKey: UserDefaultHelper.Key, value aValue: Any) {
        UserDefaults.standard.setValue(aValue, forKey: aKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    private func remove(_ aKey: UserDefaultHelper.Key) {
        UserDefaults.standard.removeObject(forKey: aKey.rawValue)
    }

    private func read<T>(_ aKey: UserDefaultHelper.Key) -> T? {
        return UserDefaults.standard.object(forKey: aKey.rawValue) as? T
    }
}

