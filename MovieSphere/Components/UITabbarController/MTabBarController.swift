//
//  MTabBarController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit

class MTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        
        view.backgroundColor = Colors.backGround
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.configureWithOpaqueBackground()
        tabbarAppearance.backgroundColor = Colors.backGround
        UITabBar.appearance().standardAppearance = tabbarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabbarAppearance
        
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        let searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
        let watchLishCoordinator = WatchListCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        
        homeCoordinator.start()
        searchCoordinator.start()
        watchLishCoordinator.start()
        profileCoordinator.start()
        
        viewControllers = [
            homeCoordinator.navigationController,
            searchCoordinator.navigationController,
            watchLishCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
    }
}
