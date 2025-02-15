//
//  LoginAdapterError.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import Foundation

enum LoginAdapterError:String, Error {
    case unableToLogin = "If you want to login with Google. Please try again!"
    case doNotHaveAnAccount = "I don't have a developer account to connect this login type."
}
