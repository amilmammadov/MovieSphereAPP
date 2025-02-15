//
//  MovieDetailViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation
import FirebaseFirestore

class MovieDetailViewModel {
    
    var movieDetail: MovieDetailModel?
    var movieReviews: [Review]?
    var movieCast: [Actor]?
    
    var successCallBackForMovieDetail: (()->Void)?
    var successCallBackForCheckMovie: (()->Void)?
    
    var errorCallBackForMovieDetail: ((String)->Void)?
    var errorsCallBackForCheckMovie: ((String)->Void)?
    var errorCallBackWhenAddingDatabase: ((String)->Void)?
    var errorCallBackForRemoveFromDatabase: ((String)->Void)?
    
    func getMovieDetail(id: Int){
        
        MovieDetailManager.shared.getMovieDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            
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
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieReviews = data.results
            case .failure(let error):
                break
            }
        }
    }
    
    func getMovieCast(id: Int){
        
        MovieDetailManager.shared.getMovieCast(id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieCast = data.cast ?? []
            case .failure(let error):
                break
            }
        }
    }
    
    func addMovieToDatabase(movie: MovieDetailModel) {
        
        FirebaseManager.shared.addMovieToDatabase(movie: movie) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorCallBackWhenAddingDatabase?(error.rawValue)
            }
        }
    }
    
    func checkMovieInDatabase(movieId: Int) {
        
        FirebaseManager.shared.checKMovieInDatabase(movieId: movieId) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.successCallBackForCheckMovie?()
                return
            }
        }
    }
    
    func removeMovieFromWatchlist(movieId: Int){
        
        FirebaseManager.shared.removeFromDatabase(movieId: movieId) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorCallBackForRemoveFromDatabase?(error.rawValue)
            }
        }
    }
}
