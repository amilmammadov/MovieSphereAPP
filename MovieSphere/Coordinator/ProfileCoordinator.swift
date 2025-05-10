//
//  ProfileCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let profileViewController = ProfileViewController()
        profileViewController.title = ConstantStrings.profileTitle.localize
        let profileViewModel = ProfileViewModel()
        
        profileViewController.profileViewModel = profileViewModel
        
        navigationController.viewControllers = [profileViewController]
    }
}
