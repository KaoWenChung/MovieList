//
//  Created by wyn on 2023/2/15.
//

import XCTest
@testable import MovieList

final class LoginUseCaseTests: XCTestCase {
    struct LoginRepositoryMock: LoginRepositoryType {
        let result: Result<Void, Error>
        init(result: Result<Void, Error>) {
            self.result = result
        }
        func login(value: LoginValue, completion: @escaping (Result<Void, Error>) -> Void) {
            completion(result)
        }
    }
    class BioRepositoryMock: BioRepositoryType {
        var email: String?
        var result: Result<AccountValue, Error>
        var bioAuthOn: Bool
        var saveEmail: Bool
        init(email: String? = nil,
             result: Result<AccountValue,
             Error>,
             bioAuthOn: Bool,
             saveEmail: Bool) {
            self.email = email
            self.result = result
            self.bioAuthOn = bioAuthOn
            self.saveEmail = saveEmail
        }
        func fetchSavedEmail() -> String? {
            email
        }
        
        func fetchAccount(completion: @escaping (Result<AccountValue, Error>) -> Void) {
            completion(result)
        }
        
        func isBioAuthOn() -> Bool {
            bioAuthOn
        }
        
        func toggleBioAuth(_ isOn: Bool) {
            bioAuthOn = isOn
        }
        
        func isSaveEmail() -> Bool {
            saveEmail
        }
        
        func toggleSaveEmail(_ isOn: Bool) {
            saveEmail = isOn
        }
    }
    func testLoginUseCase_loginSuccessflly() {
        // give
        let expectation = self.expectation(description: "Login successfully")
        let account = AccountValue(email: "test@gmail.com", password: "testPassword")
        let bioRepo = BioRepositoryMock(result: .success(account), bioAuthOn: false, saveEmail: false)
        let loginRepo = LoginRepositoryMock(result: .success(()))
        let sut = LoginUseCase(bioRepository: bioRepo, loginRepository: loginRepo)
        // when
        let value = LoginValue(isEmailSaved: false, isBioAuthOn: false, account: account)
        sut.login(value: value, completion: { result in
            if case .success(_) = result {
                expectation.fulfill()
            }
        })
        // Then
        waitForExpectations(timeout: 5, handler: nil)
    }
}
