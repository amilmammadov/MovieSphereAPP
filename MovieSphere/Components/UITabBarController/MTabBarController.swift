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
        viewControllers = [homeViewControllerConfigure(), searchViewControllerConfigure(), watchListViewControllerConfigure()]
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.configureWithOpaqueBackground()
        tabbarAppearance.backgroundColor = Colors.backGround
        UITabBar.appearance().standardAppearance = tabbarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabbarAppearance
    }
    private func homeViewControllerConfigure()->UINavigationController{
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        return homeNavigationController
    }
    private func searchViewControllerConfigure()->UINavigationController{
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Search"), tag: 1)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        return searchNavigationController
    }
    private func watchListViewControllerConfigure()->UINavigationController{
        let watchListViewController = WatchListViewController()
        watchListViewController.title = "Watch List"
        watchListViewController.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(named: "WatchList"), tag: 0)
        let watchListNavigationController = UINavigationController(rootViewController: watchListViewController)
        return watchListNavigationController
    }
}
