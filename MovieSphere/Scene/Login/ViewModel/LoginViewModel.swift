//
//  LoginViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import Foundation

class LoginViewModel {
    
    var loginAdapter: LoginAdapter?
    var successCallBackForLogin: ((UserModel)->Void)?
    
    func login(loginType: LoginType){
        
        loginAdapter?.login(loginType: loginType){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.successCallBackForLogin?(user)
            case .failure(let error):
                print(error)
            }
        }
    }
}
