//
//  UserDefaultHelper.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

final class UserDefaultsHelper {
    private enum Key: String {
        case account = "owenkao.MovieList.account"
    }

    private init() {}
    static let shared = UserDefaultsHelper()
    
    func removeUserData() {
        remove(.account)
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

    private func save(_ aKey: UserDefaultsHelper.Key, value aValue: Any) {
        UserDefaults.standard.setValue(aValue, forKey: aKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    private func remove(_ aKey: UserDefaultsHelper.Key) {
        UserDefaults.standard.removeObject(forKey: aKey.rawValue)
    }

    private func read<T>(_ aKey: UserDefaultsHelper.Key) -> T? {
        return UserDefaults.standard.object(forKey: aKey.rawValue) as? T
    }
}

