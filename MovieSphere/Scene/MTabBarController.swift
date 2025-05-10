//
//  MTabBarController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit

struct TabItem {
    let image: UIImage
    let title: String
}

class MTabBarController: UITabBarController {
    
    private let tabBarItems: [TabItem] = [
        .init(image: UIImage(named: "Home") ?? UIImage(), title: ConstantStrings.homeTitle.localize),
        .init(image: UIImage(named: "Search") ?? UIImage(), title: ConstantStrings.searchTitle.localize),
        .init(image: UIImage(named: "WatchList") ?? UIImage(), title: ConstantStrings.watchListTitle.localize),
        .init(image: UIImage(systemName: "person.crop.circle") ?? UIImage(), title: ConstantStrings.profileTitle.localize)
    ]

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
        
        viewControllers?.enumerated().forEach({ index, viewController in
            
            let tabItem = tabBarItems[index]
            
            viewController.tabBarItem = UITabBarItem(title: tabItem.title, image: tabItem.image, tag: index)
        })
    }
}
