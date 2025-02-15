//
//  MovieTabBarController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

class MTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    private func configure(){
        
        view.backgroundColor = Colors.backGround
        viewControllers = [homeViewControllerConfigure(), searchViewControllerConfigure(), watchListViewControllerConfigure(), profileViewControllerConfigure()]
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.configureWithOpaqueBackground()
        tabbarAppearance.backgroundColor = Colors.backGround
        UITabBar.appearance().standardAppearance = tabbarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabbarAppearance
    }
    private func homeViewControllerConfigure()->UINavigationController{
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "home_title".localize, image: UIImage(named: "Home"), tag: 0)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        return homeNavigationController
    }
    private func searchViewControllerConfigure()->UINavigationController{
        let searchViewController = SearchViewController()
        searchViewController.title = "search_title".localize
        searchViewController.tabBarItem = UITabBarItem(title: "search_title".localize, image: UIImage(named: "Search"), tag: 1)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        return searchNavigationController
    }
    private func watchListViewControllerConfigure()->UINavigationController{
        let watchListViewController = WatchListViewController()
        watchListViewController.title = "watchlist_title".localize
        watchListViewController.tabBarItem = UITabBarItem(title: "watchlist_title".localize, image: UIImage(named: "WatchList"), tag: 2)
        let watchListNavigationController = UINavigationController(rootViewController: watchListViewController)
        return watchListNavigationController
    }
    
    private func profileViewControllerConfigure()->UINavigationController {
        let profileViewController = ProfileViewController()
        profileViewController.title = "profile_title".localize
        profileViewController.tabBarItem = UITabBarItem(title: "profile_title".localize, image: UIImage(systemName: "person.crop.circle"), tag: 3)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        return profileNavigationController
    }
}
