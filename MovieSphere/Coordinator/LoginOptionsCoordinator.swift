//
//  LoginOptionsCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.05.25.
//

import UIKit

final class LoginOptionsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var viewController: UIViewController
    
    init(navigationController: UINavigationController, viewController: UIViewController) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    func start() {
        let loginOptionsViewController = LoginOptionsViewController()
        let loginOptionsViewModel = LoginOptionsViewModel()
        
        loginOptionsViewController.loginOptionsViewModel = loginOptionsViewModel
        loginOptionsViewModel.loginAdapter = LoginAdapter(controller: loginOptionsViewController)
        
        viewController.presentModalViewController(loginOptionsViewController)
    }
}
