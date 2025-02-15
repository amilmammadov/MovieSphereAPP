//
//  LoginAdapter.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import Foundation
import GoogleSignIn

enum LoginType:String {
    case google = "Google"
    case apple = "Apple"
    case facebook = "Facebook"
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
        case .facebook:
            loginWithFacebook()
        }
    }
    
    private func loginWithGoogle(completion: @escaping((Result<UserModel, LoginAdapterError>)->Void)){
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { signInResult, error in
            
            if let _ = error { completion(.failure(.unableToLogin)) }
            
            guard let result = signInResult else { return }
            
            let user = UserModel(name: result.user.profile?.name ?? "",
                                 email: result.user.profile?.email ?? "",
                                 profileImageUrl: result.user.profile?.imageURL(withDimension: 200)?.absoluteString ?? "")
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData, forKey: LoginType.google.rawValue)
                completion(.success(user))
            }catch{
                completion(.failure(.unableToLogin))
            }
          }
    }
    
    private func loginWithApple(){}
    
    private func loginWithFacebook(){}
}


