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
    
    func test_BioAuthLoginOnViewDidLoad_Success() {
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
        XCTAssertEqual(sut.savedAccount, "user@mock.com")
        wait(for: [expectation], timeout: 0.1)
    }

    func test_didSelectRegister_sendEventToLoginViewModelActions() {
        // given
        let loginUseCase = LoginUseCaseMock()
        let expectation = self.expectation(description: "Should execute didRegister")
        let actions = LoginViewModelActions(didLogin: {}, didRegister: {
            expectation.fulfill()
        })
        let sut = LoginViewModel(loginUseCase: loginUseCase, actions: actions)
        // when
        sut.didSelectRegister()
        // then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_didSelectLogin_sendEventToLoginViewModelActions() {
        // given
        let loginUseCase = LoginUseCaseMock()
        let expectation = self.expectation(description: "Should execute didSelectLogin")
        let actions = LoginViewModelActions(didLogin: {
            expectation.fulfill()
        }, didRegister: {})
        let sut = LoginViewModel(loginUseCase: loginUseCase, actions: actions)
        // when
        sut.didSelectLogin(AccountValue(email: "mock@test.com", password: "mockPassword"))
        // then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_BioAuthLoginOffViewDidLoad_NotLogin() {
        // given
        let loginUseCase = LoginUseCaseMock()
        loginUseCase.bioAuthOn = false
        loginUseCase.saveEmailOn = true
        loginUseCase.savedEmail = "user@mock.com"
        let actions = LoginViewModelActions(didLogin: {
            XCTFail("Should not call this function")
        }, didRegister: {})
        let sut = LoginViewModel(loginUseCase: loginUseCase, actions: actions)
        // when
        sut.viewDidLoad()
        // then
        XCTAssertEqual(sut.savedAccount, "user@mock.com")
    }

    func test_savedEmailOffViewDidLoad_savedAccountShouldBeNil() {
        // given
        let loginUseCase = LoginUseCaseMock()
        loginUseCase.bioAuthOn = false
        loginUseCase.saveEmailOn = false
        let actions = LoginViewModelActions(didLogin: {}, didRegister: {})
        let sut = LoginViewModel(loginUseCase: loginUseCase, actions: actions)
        // when
        sut.viewDidLoad()
        // then
        XCTAssertNil(sut.savedAccount)
    }
}
