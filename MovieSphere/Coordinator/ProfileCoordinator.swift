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
        profileViewController.tabBarItem = UITabBarItem(title: ConstantStrings.profileTitle.localize, image: UIImage(systemName: "person.crop.circle"), tag: 3)
        navigationController.viewControllers = [profileViewController]
    }
}
