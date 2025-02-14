//
//  LoginAdapter.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import Foundation
import GoogleSignIn

enum LoginType {
    case google
    case apple
}

class LoginAdapter {
    
    var controller: LoginOptionsViewController
    init(controller: LoginOptionsViewController) {
        self.controller = controller
    }
    
    func login(loginType: LoginType, completion: @escaping((Result<UserModel, LoginAdapterError>)->Void)){
        
        switch loginType {
        case .google:
            loginWithGoogle(completion: completion)
        case .apple:
            loginWithApple()
        }
    }
    
    private func loginWithGoogle(completion: @escaping((Result<UserModel, LoginAdapterError>)->Void)){
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { signInResult, error in
            
            if let _ = error { completion(.failure(.unableToLogin)) }
            
            guard let result = signInResult else { return }
            
            let user = UserModel(name: result.user.profile?.name ?? "",
                                 surname: result.user.profile?.familyName ?? "",
                                 email: result.user.profile?.email ?? "")
            
            completion(.success(user))
          }
    }
    
    private func loginWithApple(){}
}


