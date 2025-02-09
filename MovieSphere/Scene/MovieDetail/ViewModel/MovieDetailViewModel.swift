//
//  MovieDetailViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

class MovieDetailViewModel {
    
    var movieDetail: MovieDetailModel?
    var movieReviews: [Review]?
    var movieCast: [Actor]?
    var successCallBackForMovieDetail: (()->Void)?
    
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
}
