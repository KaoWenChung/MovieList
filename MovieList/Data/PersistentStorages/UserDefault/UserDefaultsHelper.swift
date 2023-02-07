//
//  UserDefaultHelper.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

protocol BioRepoUserDefaultsType {
    func toggleBioAuth(_ isOn: Bool)
    func readBioAuth() -> Bool?
    func saveAccount(_ newValue: String)
    func readAccount() -> String?
    func toggleSaveEmail(_ isOn: Bool)
    func readSaveEmail() -> Bool?
    func removeUserData()
}

final class UserDefaultsHelper {
    private enum Key: String {
        case account = "owenkao.MovieList.account"
        case bioAuth = "owenkao.MovieList.bioAuth"
        case saveEmail = "owenkao.MovieList.saveEmail"
    }

    private func save(_ aKey: UserDefaultsHelper.Key, value aValue: Any) {
        UserDefaults.standard.setValue(aValue, forKey: aKey.rawValue)
        UserDefaults.standard.synchronize()
    }

    private func remove(_ aKey: UserDefaultsHelper.Key) {
        UserDefaults.standard.removeObject(forKey: aKey.rawValue)
    }

    private func read<T>(_ aKey: UserDefaultsHelper.Key) -> T? {
        UserDefaults.standard.object(forKey: aKey.rawValue) as? T
    }
}

extension UserDefaultsHelper: BioRepoUserDefaultsType {
    func removeUserData() {
        remove(.account)
        remove(.bioAuth)
    }

    func saveAccount(_ newValue: String) {
        save(.account, value: newValue)
    }

    func readAccount() -> String? {
        read(.account)
    }

    func toggleBioAuth(_ isOn: Bool) {
        save(.bioAuth, value: isOn)
    }

    func readBioAuth() -> Bool? {
        read(.bioAuth)
    }

    func toggleSaveEmail(_ isOn: Bool) {
        save(.saveEmail, value: isOn)
    }

    func readSaveEmail() -> Bool? {
        read(.saveEmail)
    }
}
