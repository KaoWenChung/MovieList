//
//  LoginRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginRepositoryType {
    func fetchSavedEmail() -> String?
    func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void)
    func isBioAuthOn() -> Bool
    func toggleBioAuth(_ isOn: Bool)
    func isSaveEmail() -> Bool
    func toggleSaveEmail(_ isOn: Bool)
    func login(value: LoginValue,
               completion: @escaping (Result<Void, Error>) -> Void)
}
