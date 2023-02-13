//
//  UserDefaultHelper.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

final class LoginUserDefaultStorage {
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }

    private enum Key: String {
        case email = "owenkao.MovieList.email"
        case bioAuth = "owenkao.MovieList.bioAuth"
        case saveEmail = "owenkao.MovieList.saveEmail"
    }

    private func save(_ aKey: LoginUserDefaultStorage.Key, value aValue: Any) {
        userDefault.setValue(aValue, forKey: aKey.rawValue)
        userDefault.synchronize()
    }

    private func remove(_ aKey: LoginUserDefaultStorage.Key) {
        userDefault.removeObject(forKey: aKey.rawValue)
    }

    private func read<T>(_ aKey: LoginUserDefaultStorage.Key) -> T? {
        userDefault.object(forKey: aKey.rawValue) as? T
    }
}

extension LoginUserDefaultStorage: LoginStorageType {
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
