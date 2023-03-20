//
//  LoginViewModelTests.swift
//  MovieListTests
//
//  Created by wyn on 2023/3/20.
//

import XCTest
@testable import MovieList

final class LoginViewModelTests: XCTestCase {
    class LoginUseCaseMock: LoginUseCaseType {
        var savedEmail: String?
        var error: Error?
        var bioAuthOn = false
        var saveEmailOn = false
        
        func fetchSavedEmail() -> String? {
            savedEmail
        }
        
        func login(value: LoginValue, completion: @escaping (Error?) -> Void) {
            completion(error)
        }
        
        func loginByBioAuth(completion: @escaping (Error?) -> Void) {
            completion(error)
        }
        
        func isBioAuthOn() -> Bool {
            bioAuthOn
        }
        
        func isSaveEmailOn() -> Bool {
            saveEmailOn
        }
    }
    
    func test_viewDidLoadLoginByBioAuthSuccessfully() {
        // given
        let loginUseCase = LoginUseCaseMock()
        loginUseCase.bioAuthOn = true
        loginUseCase.saveEmailOn = true
        loginUseCase.savedEmail = "user@mock.com"
        let expectation = self.expectation(description: "Should login successfully")
        let actions = LoginViewModelActions(didLogin: {
            expectation.fulfill()
        }, didRegister: {})
        let sut = LoginViewModel(loginUseCase: loginUseCase, actions: actions)
        // when
        sut.viewDidLoad()
        // then
        wait(for: [expectation], timeout: 0.1)
    }
}
