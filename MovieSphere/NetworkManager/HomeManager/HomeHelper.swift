//
//  HomeHelper.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

enum HomeEndPoints:String {
    case nowPlaying = "movie/now_playing"
    case upComing = "movie/upcoming"
    case topRated = "movie/top_rated"
    case popular = "movie/popular"
    
    var path: String {
        let language = UserDefaults.standard.string(forKey: ConstantStrings.selectedLanguage)
        return NetworkHelper.shared.urlConfig(path: self.rawValue, language: language ?? "en-US")
    }
}
