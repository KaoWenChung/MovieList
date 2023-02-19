//
//  FirebaseAuthenticationType.swift
//  MovieList
//
//  Created by wyn on 2023/2/14.
//

import FirebaseAuth

protocol FirebaseAuthType {
    func signOut() throws
    func signIn(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?)
    func createUser(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?)
}

protocol FirebaseAuthDataResultType {
    var user: User { get }
}

extension AuthDataResult: FirebaseAuthDataResultType {}

extension Auth: FirebaseAuthType {
    func createUser(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?) {
        createUser(withEmail: email, password: password, completion: completion)
    }
    
    func signIn(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?) {
        signIn(withEmail: email, password: password, completion: completion)
    }
}
