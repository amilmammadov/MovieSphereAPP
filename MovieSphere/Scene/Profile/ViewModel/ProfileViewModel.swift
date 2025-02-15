//
//  ProfileViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 15.02.25.
//

import Foundation

class ProfileViewModel {

    var successCallBackForProfile: ((UserModel)->Void)?
    
    func retrieveData(){
        
        do{
            guard let userData = UserDefaults.standard.object(forKey: LoginType.google.rawValue) as? Data else { return }
            let decoder = JSONDecoder()
            let user = try decoder.decode(UserModel.self, from: userData)
            successCallBackForProfile?(user)
        }catch{
            print("error")
        }
    }
}
