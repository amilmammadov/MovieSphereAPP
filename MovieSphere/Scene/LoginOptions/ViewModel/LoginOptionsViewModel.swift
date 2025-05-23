//
//  LoginViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import Foundation

protocol LoginOptionsViewModelProtocol {
    
    var loginAdapter: LoginAdapter? { get set }
    var successCallBackForLogin: ((UserModel)->Void)? { get set }
    var errorCallBackForLogin: ((String)->Void)? { get set }
    
    func login(loginType: LoginType)
}

final class LoginOptionsViewModel: LoginOptionsViewModelProtocol {
    
    var loginAdapter: LoginAdapter?
    var successCallBackForLogin: ((UserModel)->Void)?
    var errorCallBackForLogin: ((String)->Void)?
    
    func login(loginType: LoginType){
        
        loginAdapter?.login(loginType: loginType){ [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                self.successCallBackForLogin?(user)
            case .failure(let error):
                self.errorCallBackForLogin?(error.rawValue)
            }
        }
    }
}
