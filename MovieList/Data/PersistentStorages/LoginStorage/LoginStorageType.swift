//
//  LoginStorageType.swift
//  MovieList
//
//  Created by wyn on 2023/2/11.
//

protocol LoginStorageType {
    func toggleBioAuth(_ isOn: Bool)
    func readBioAuth() -> Bool?
    func saveEmail(_ newValue: String)
    func readEmail() -> String?
    func toggleSaveEmail(_ isOn: Bool)
    func readSaveEmail() -> Bool?
    func removeUserData()
}
