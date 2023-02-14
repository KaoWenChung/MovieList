//
//  FirebaseAuthenticationType.swift
//  MovieList
//
//  Created by wyn on 2023/2/14.
//

import FirebaseAuth

protocol FirebaseAuthenticationType {
    func signOut() throws
}

extension Auth: FirebaseAuthenticationType {}
