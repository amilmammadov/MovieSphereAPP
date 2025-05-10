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
        let searchViewModel = SearchViewModel()
        
        searchViewController.searchViewModel = searchViewModel
        searchViewModel.searchCoordinator = self
        
        navigationController.viewControllers = [searchViewController]
    }
    
    func goToMovieDetailPage(movieId: Int){
        
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController, movieId: movieId)
        movieDetailCoordinator.start()
    }
}
