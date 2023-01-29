//
//  LoginRepository.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol LoginRepositoryType {
    func login(account: AccountValue,
               completion: @escaping (Result<Void, Error>) -> Void)
}
