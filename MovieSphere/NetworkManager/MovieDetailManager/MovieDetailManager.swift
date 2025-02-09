//
//  MovieDetailManager.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

class MovieDetailManager {
    static let shared = MovieDetailManager()
    
    let language = UserDefaults.standard.string(forKey: ConstantStrings.selectedLanguage)
    
    func getMovieDetail(id: Int, completion: @escaping ((Result<MovieDetailModel, NetworkError>)->Void)){
        
        NetworkManager.shared.request(model: MovieDetailModel.self, url: NetworkHelper.shared.urlConfig(path: "movie/\(id)", language: language ?? "eng"), completion: completion)
    }
    
    func getReviesForMovie(id: Int, completion: @escaping ((Result<ReviewsModel, NetworkError>)->Void)){
        
        NetworkManager.shared.request(model: ReviewsModel.self, url: NetworkHelper.shared.urlConfig(path: "movie/\(id)/reviews", language: language ?? "eng"), completion: completion)
    }
    
    func getMovieCast(id: Int, completion: @escaping ((Result<MovieCastModel, NetworkError>)->Void)){
        
        NetworkManager.shared.request(model: MovieCastModel.self, url: NetworkHelper.shared.urlConfig(path: "movie/\(id)/credits", language: language ?? "eng"), completion: completion)
    }
}
