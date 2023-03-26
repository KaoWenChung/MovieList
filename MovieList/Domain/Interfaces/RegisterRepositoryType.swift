//
//  RegisterRepositoryType.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

protocol RegisterRepositoryType {
    func register(account: AccountValue,
                  completion: @escaping (Error?) -> Void)
}
