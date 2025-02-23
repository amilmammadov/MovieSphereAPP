//
//  SearchCoordinator.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 23.02.25.
//

import UIKit

class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        
        let searchViewController = SearchViewController()
        searchViewController.title = ConstantStrings.searchTitle.localize
        searchViewController.tabBarItem = UITabBarItem(title: ConstantStrings.searchTitle.localize, image: UIImage(named: "Search"), tag: 1)
        searchViewController.searchCoordinator = self
        navigationController.viewControllers = [searchViewController]
    }
    
    func goToMovieDetailPage(movieId: Int){
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movieId = movieId
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
