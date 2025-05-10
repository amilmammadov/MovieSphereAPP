//
//  HomeViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

protocol HomeViewModelProtocol {
    
    var horizontalCollectionMovies: [Movie] { get set }
    var singleCategoryCollectionMovies:  [Movie] { get set }
    var selectedCategery: Category { get set }
    
    var successCallBackForHorizontalCMovies: (()->Void)? { get set }
    var successCallBackForSingleCategoryMovies: (()->Void)? { get set }
    
    var errorCallBackForHorizontalCMovies: ((String)->Void)? { get set }
    var errroCallBackForSingleCategoryMovies: ((String)->Void)? { get set }
    
    var movieCategories: [String] { get }
    
    func getHorizontalCollectionMovies(category: Category)
    func getSingleCategoryMovies(category: Category, isNewCategory: Bool)
    func horizontalCollectionPagination()
    func verticalCollectionPagination(category: Category)
    
    func goToMovieDetail(movieId: Int)
}

final class HomeViewModel: HomeViewModelProtocol {
    
    var horizontalCollectionMovies = [Movie]()
    var singleCategoryCollectionMovies = [Movie]()
    var selectedCategery: Category = .nowPlaying
    
    var successCallBackForHorizontalCMovies: (()->Void)?
    var successCallBackForSingleCategoryMovies: (()->Void)?
    var errorCallBackForHorizontalCMovies: ((String)->Void)?
    var errroCallBackForSingleCategoryMovies: ((String)->Void)?
    
    private var horizontalMoviesPage: Int = 1
    private var horizontalCollectionMovieModel: MovieModel?
    private var verticalMoviesPage: Int = 1
    private var verticalCollectionMovieModel: MovieModel?
    
    var movieCategories: [String] {
        return Category.allCases.map {$0.rawValue}
    }
    
    var homeCoordinator: HomeCoordinator?
    
    func getHorizontalCollectionMovies(category: Category){
        
        HomeManager.shared.getHomePageMovies(category: category, page: horizontalMoviesPage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.horizontalCollectionMovieModel = data
                self.horizontalCollectionMovies.append(contentsOf: data.results ?? [])
                successCallBackForHorizontalCMovies?()
            case .failure(let error):
                self.errorCallBackForHorizontalCMovies?(error.rawValue)
            }
        }
    }
    
    func getSingleCategoryMovies(category: Category, isNewCategory: Bool){
        
        if isNewCategory {
            self.verticalMoviesPage = 1
        }
        
        HomeManager.shared.getHomePageMovies(category: category, page: verticalMoviesPage) { [weak self] result in
            guard let self else { return }
            
            if isNewCategory {
                self.singleCategoryCollectionMovies = []
            }
            
            switch result {
            case .success(let data):
                self.singleCategoryCollectionMovies.append(contentsOf: data.results ?? [])
                self.successCallBackForSingleCategoryMovies?()
            case .failure(let error):
                self.errroCallBackForSingleCategoryMovies?(error.rawValue)
            }
        }
    }
    
    func horizontalCollectionPagination(){
        
        if (horizontalCollectionMovieModel?.page ?? 0) <= (horizontalCollectionMovieModel?.totalPages ?? 0) {
            horizontalMoviesPage += 1
            getHorizontalCollectionMovies(category: .popular)
        }
    }
    
    func verticalCollectionPagination(category: Category){
        
        if (verticalCollectionMovieModel?.page ?? 0) <= (verticalCollectionMovieModel?.totalPages ?? 0) {
            verticalMoviesPage += 1
            getSingleCategoryMovies(category: category, isNewCategory: false)
        }
    }
    
    func goToMovieDetail(movieId: Int) {
        homeCoordinator?.goToMovieDetailPage(movieId: movieId)
    }
}
