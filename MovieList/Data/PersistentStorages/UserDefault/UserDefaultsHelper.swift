//
//  UserDefaultHelper.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

protocol UserDefaultsHelperType {
    func saveAccount(_ newValue: String)
    func readAccount() -> String?
    func removeUserData()
}

final class UserDefaultsHelper {
    private enum Key: String {
        case account = "owenkao.MovieList.account"
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

extension UserDefaultsHelper: UserDefaultsHelperType {
    func removeUserData() {
        remove(.account)
    }

    func saveAccount(_ newValue: String) {
        save(.account, value: newValue)
    }

    func readAccount() -> String? {
        read(.account)
    }
}
