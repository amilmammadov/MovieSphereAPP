//
//  ProfileViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 15.02.25.
//

import Foundation

final class ProfileViewModel {

    var successCallBackForProfile: ((UserModel)->Void)?
    var errorCallBackForProfile: ((String)->Void)?
    
    func retrieveData(){
        
        do{
            guard let userData = UserDefaults.standard.object(forKey: LoginType.google.rawValue) as? Data else { return }
            let decoder = JSONDecoder()
            let user = try decoder.decode(UserModel.self, from: userData)
            successCallBackForProfile?(user)
        }catch{
            errorCallBackForProfile?("The problem occured when trying to get profile data!")
        }
    }
}
