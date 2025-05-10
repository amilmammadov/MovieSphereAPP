//
//  File.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 10.05.25.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var movieId: Int
    
    init(navigationController: UINavigationController, movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
    
    func start() {
        
        let movieDetailViewController = MovieDetailViewController()
        let movieDetailViewModel = MovieDetailViewModel()
        
        movieDetailViewController.movieDetailViewModel = movieDetailViewModel
        movieDetailViewModel.movieId = movieId

        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
