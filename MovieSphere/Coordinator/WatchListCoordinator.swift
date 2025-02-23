//
//  WatchListCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit

class WatchListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let watchListViewController = WatchListViewController()
        watchListViewController.title = ConstantStrings.watchListTitle.localize
        watchListViewController.tabBarItem = UITabBarItem(title: ConstantStrings.watchListTitle.localize, image: UIImage(named: "WatchList"), tag: 2)
        watchListViewController.watchListCoordinator = self
        navigationController.viewControllers = [watchListViewController]
    }
    
    func goToMovieDetailPage(movieId: Int){
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movieId = movieId
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
