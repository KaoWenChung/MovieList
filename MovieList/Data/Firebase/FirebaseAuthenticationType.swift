//
//  FirebaseAuthenticationType.swift
//  MovieList
//
//  Created by wyn on 2023/2/14.
//

import FirebaseAuth

protocol FirebaseAuthenticationType {
    func signOut() throws
    func signIn(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?)
}

protocol FirebaseAuthDataResultType {
    var user: User { get }
}

extension AuthDataResult: FirebaseAuthDataResultType {}

extension Auth: FirebaseAuthenticationType {
    func signIn(email: String, password: String, completion: ((FirebaseAuthDataResultType?, Error?) -> Void)?) {
        signIn(withEmail: email, password: password, completion: completion)
    }
    
    
}
