//
//  LoginRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginRepositoryType {
    func fetchSavedEmail() -> String?
    func isBioAuthOn() -> Bool
    func isSaveEmail() -> Bool
    func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void)
    func login(value: LoginValue, completion: @escaping (Error?) -> Void)
}
