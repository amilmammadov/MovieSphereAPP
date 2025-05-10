//
//  LoginCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.05.25.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    var window: UIWindow
    var navigationController: UINavigationController
    var loginViewController: LoginViewController?
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        
        loginViewController = LoginViewController()
        let loginViewModel = LoginViewModel()
        
        loginViewController?.loginViewModel = loginViewModel
        loginViewModel.loginCoordinator = self
        
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
    
    func presentLoginOptionsViewController(){
        let loginOptionsCoordinator = LoginOptionsCoordinator(navigationController: navigationController, viewController: loginViewController ?? UIViewController())
        loginOptionsCoordinator.start()
    }
}
