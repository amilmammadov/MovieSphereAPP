//
//  SceneDelegate.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = Colors.backGround
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
        window?.rootViewController = MTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func putLoginPageToRoot(){
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
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
       
        guard let window = window, let tabBarController = window.rootViewController as? UITabBarController else { return }
        
        let selectedIndex = tabBarController.selectedIndex
        let newTabBarController = MTabBarController()
        newTabBarController.selectedIndex = selectedIndex
        window.rootViewController = newTabBarController
        window.makeKeyAndVisible()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}
