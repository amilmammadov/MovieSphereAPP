//
//  LoginViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.05.25.
//

import Foundation

protocol LoginViewModelProtocol {
    
    func presentLiginOptions()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var loginCoordinator: LoginCoordinator?
    func presentLiginOptions() {
        loginCoordinator?.presentLoginOptionsViewController()
    }
}
