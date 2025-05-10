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
        let homeViewModel = HomeViewModel()
        let searchViewModel = SearchViewModel()
        
        homeViewController.homeViewModel = homeViewModel
        homeViewController.searchViewModel = searchViewModel    
        homeViewModel.homeCoordinator = self
        
        navigationController.viewControllers = [homeViewController]
    }
    
    func goToMovieDetailPage(movieId: Int){
        
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController, movieId: movieId)
        movieDetailCoordinator.start()
    }
}
