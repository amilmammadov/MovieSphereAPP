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
        let watchListViewModel = WatchListViewModel()
        
        watchListViewController.watchListViewModel = watchListViewModel
        watchListViewModel.watchListCoordinator = self
        
        navigationController.viewControllers = [watchListViewController]
    }
    
    func goToMovieDetailPage(movieId: Int){
        
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController, movieId: movieId)
        movieDetailCoordinator.start()
    }
}
