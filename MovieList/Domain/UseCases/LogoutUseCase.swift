//
//  LogoutUseCase.swift
//  MovieList
//
//  Created by wyn on 2023/2/1.
//

protocol LogoutUseCaseType {
    func execute()
}

struct LogoutUseCase: LogoutUseCaseType {
    private let logoutRepository: LogoutRepositoryType

    init(logoutRepository: LogoutRepositoryType) {
        self.logoutRepository = logoutRepository
    }
    func execute() {
        logoutRepository.logout()
    }
}
