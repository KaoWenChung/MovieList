//
//  LoginStorageType.swift
//  MovieList
//
//  Created by wyn on 2023/2/11.
//

protocol LoginUserDefaultStorageType {
    func toggleBioAuth(_ isOn: Bool)
    func readBioAuth() -> Bool?
    func saveEmail(_ newValue: String)
    func readEmail() -> String?
    func toggleSaveEmail(_ isOn: Bool)
    func readSaveEmail() -> Bool?
    func removeUserData()
}

protocol LoginKeychainStorageType {
    func savePassword(_ password: String, account: String)
    func readPassword(account: String) -> String?
    func removePassword(account: String)
}
