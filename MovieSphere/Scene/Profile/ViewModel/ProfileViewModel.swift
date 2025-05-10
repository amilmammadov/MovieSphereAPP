//
//  ProfileViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 15.02.25.
//

import Foundation
import GoogleSignIn

protocol ProfileViewModelProtocol {
    
    var successCallBackForProfile: ((UserModel)->Void)? { get set }
    var errorCallBackForProfile: ((String)->Void)? { get set }
    
    func retrieveData()
    func logOut()
    func setLanguageAndReload(staticStringsLanguage: String, apiQuerylanguage: String)
}

final class ProfileViewModel: ProfileViewModelProtocol {

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
    
    func logOut(){
        
        GIDSignIn.sharedInstance.signOut()
        UserDefaults.standard.removeObject(forKey: LoginType.google.rawValue)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.appCoordinator?.putLoginPageToRoot()
        }
    }
    
    func setLanguageAndReload(staticStringsLanguage: String, apiQuerylanguage: String){
        
        UserDefaults.standard.set(apiQuerylanguage, forKey: ConstantStrings.selectedLanguage)
        UserDefaults.standard.set(staticStringsLanguage, forKey: Language.key.rawValue)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.appCoordinator?.reload()
        }
    }
}
