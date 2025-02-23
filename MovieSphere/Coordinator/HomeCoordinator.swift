//
//  HomeCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: ConstantStrings.homeTitle.localize, image: UIImage(named: "Home"), tag: 0)
        homeViewController.homeCoordinator = self
        navigationController.viewControllers = [homeViewController]
    }
    
    func goToMovieDetailPage(movieId: Int){
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movieId = movieId
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
