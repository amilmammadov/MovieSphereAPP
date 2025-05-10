//
//  MovieDetailViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation
import FirebaseFirestore

protocol MovieDetailViewModelProtocol {
    
    var movieDetail: MovieDetailModel? { get set }
    var movieReviews: [Review]? { get set }
    var movieCast: [Actor]? { get set }
    var movieId: Int? { get set }
    var tappedButton: String { get set }
    
    var successCallBackForMovieDetail: (()->Void)? { get set }
    var successCallBackForCheckMovie: (()->Void)? { get set }
    
    var errorCallBackForMovieDetail: ((String)->Void)? { get set }
    var errorsCallBackForCheckMovie: ((String)->Void)? { get set }
    var errorCallBackWhenAddingDatabase: ((String)->Void)? { get set }
    var errorCallBackForRemoveFromDatabase: ((String)->Void)? { get set }
    
    func getMovieDetail(id: Int)
    func getReviewsForMovie(id: Int)
    func getMovieCast(id: Int)
    func addMovieToDatabase(movie: MovieDetailModel)
    func checkMovieInDatabase(movieId: Int)
    func removeMovieFromWatchlist(movieId: Int)
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var movieDetail: MovieDetailModel?
    var movieReviews: [Review]?
    var movieCast: [Actor]?
    var movieId: Int?
    var tappedButton: String = ConstantStrings.aboutMovie
    
    var successCallBackForMovieDetail: (()->Void)?
    var successCallBackForCheckMovie: (()->Void)?
    
    var errorCallBackForMovieDetail: ((String)->Void)?
    var errorsCallBackForCheckMovie: ((String)->Void)?
    var errorCallBackWhenAddingDatabase: ((String)->Void)?
    var errorCallBackForRemoveFromDatabase: ((String)->Void)?
    
    func getMovieDetail(id: Int){
        
        MovieDetailManager.shared.getMovieDetail(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.movieDetail = data
                self.successCallBackForMovieDetail?()
            case .failure(let error):
                self.errorCallBackForMovieDetail?(error.rawValue)
            }
        }
    }
    
    func getReviewsForMovie(id: Int){
        
        MovieDetailManager.shared.getReviesForMovie(id: id){ [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.movieReviews = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieCast(id: Int){
        
        MovieDetailManager.shared.getMovieCast(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.movieCast = data.cast ?? []
            case .failure(_):
                break
            }
        }
    }
    
    func addMovieToDatabase(movie: MovieDetailModel) {
        
        FirebaseManager.shared.addMovieToDatabase(movie: movie) { [weak self] error in
            guard let self else { return }
            
            if let error = error {
                self.errorCallBackWhenAddingDatabase?(error.rawValue)
            }
        }
    }
    
    func checkMovieInDatabase(movieId: Int) {
        
        FirebaseManager.shared.checKMovieInDatabase(movieId: movieId) { [weak self] error in
            guard let self else { return }
            
            guard let _ = error else {
                self.successCallBackForCheckMovie?()
                return
            }
        }
    }
    
    func removeMovieFromWatchlist(movieId: Int){
        
        FirebaseManager.shared.removeFromDatabase(movieId: movieId) { [weak self] error in
            guard let self else { return }
            
            if let error = error {
                self.errorCallBackForRemoveFromDatabase?(error.rawValue)
            }
        }
    }
}
