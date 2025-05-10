//
//  AppCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit
import GoogleSignIn

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(window: UIWindow){
        
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        
        window.backgroundColor = Colors.backGround
        configureNavigationBar()
        
        if let user = GIDSignIn.sharedInstance.currentUser {
            
            let user = UserModel(name: user.profile?.name ?? "",
                                 email: user.profile?.email ?? "",
                                 profileImageUrl: user.profile?.imageURL(withDimension: 200)?.absoluteString)
            
            do{
                let encodedData = try JSONEncoder().encode(user)
                UserDefaults.standard.set(encodedData, forKey: LoginType.google.rawValue)
            }catch{
                print("")
            }
            
            putMainPageToRoot()
        }else{
            putLoginPageToRoot()
        }
    }
    
    func putMainPageToRoot(){
        
        window.rootViewController = MTabBarController()
        window.makeKeyAndVisible()
    }
    
    func putLoginPageToRoot(){
        
        let loginAdapter = LoginCoordinator(window: window, navigationController: navigationController)
        loginAdapter.start()
    }
    
    func configureNavigationBar(){
        
        if #available(iOS 15, *) {
            
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white, .font:UIFont(name: MFont.poppinsSemiBold, size: 18) ?? ""
            ]
            navigationBarAppearance.backgroundColor = Colors.backGround
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
        }
    }
    
    func reload() {
            
        guard let tabBarController = window.rootViewController as? UITabBarController else { return }
        
        let selectedIndex = tabBarController.selectedIndex
        let newTabBarController = MTabBarController()
        newTabBarController.selectedIndex = selectedIndex
        window.rootViewController = newTabBarController
        window.makeKeyAndVisible()
    }
}
