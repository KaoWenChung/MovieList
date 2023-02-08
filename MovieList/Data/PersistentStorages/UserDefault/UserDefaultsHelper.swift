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
    func saveEmail(_ newValue: String)
    func readEmail() -> String?
    func toggleSaveEmail(_ isOn: Bool)
    func readSaveEmail() -> Bool?
    func removeUserData()
}

final class UserDefaultsHelper {
    private enum Key: String {
        case email = "owenkao.MovieList.email"
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
        remove(.email)
        remove(.saveEmail)
        remove(.bioAuth)
    }

    func saveEmail(_ newValue: String) {
        save(.email, value: newValue)
    }

    func readEmail() -> String? {
        read(.email)
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
