//
//  SearchHelper.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 15.02.25.
//

import Foundation

enum MovieDetailEndPoints {
    case movieDetail(movieId: Int)
    case movieReviews(movieId: Int)
    case movieCredits(movieId: Int)
    
    var path: String {
        let language = UserDefaults.standard.string(forKey: ConstantStrings.selectedLanguage)
        switch self{
        case .movieDetail(let movieId):
            return NetworkHelper.shared.urlConfig(path: "movie/\(movieId)", language: language ?? "en-US")
        case .movieReviews(let movieId):
            return NetworkHelper.shared.urlConfig(path: "movie/\(movieId)/reviews", language: language ?? "en-US")
        case .movieCredits(let movieId):
            return NetworkHelper.shared.urlConfig(path: "movie/\(movieId)/credits", language: language ?? "en-US")
        }
    }
}
