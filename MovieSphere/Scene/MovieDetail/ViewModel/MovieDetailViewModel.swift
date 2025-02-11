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
    
    func getMovieDetail(id: Int){
        
        MovieDetailManager.shared.getMovieDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                movieDetail = data
                successCallBackForMovieDetail?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getReviewsForMovie(id: Int){
        
        MovieDetailManager.shared.getReviesForMovie(id: id){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                movieReviews = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieCast(id: Int){
        
        MovieDetailManager.shared.getMovieCast(id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                movieCast = data.cast ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addMovieToDatabase(movie: MovieDetailModel) {
        
        FirebaseManager.shared.addMovieToDatabase(movie: movie) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print(error)
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
            print(error)
        }
    }
    
    func removeMovieFromWatchlist(movieId: Int){
        
        FirebaseManager.shared.removeFromDatabase(movieId: movieId) { error in
            if let error = error {
                print(error)
            }
            
            print("Movie removed")
        }
    }
}
