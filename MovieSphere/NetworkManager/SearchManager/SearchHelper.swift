//
//  SearchHelper.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

enum SearchEndPoints:String {
    case popular = "movie/popular"
    case genreList = "genre/movie/list"
    case searchMovie = "search/movie"
    
    var path: String {
        let language = UserDefaults.standard.string(forKey: ConstantStrings.selectedLanguage)
        return NetworkHelper.shared.urlConfig(path: self.rawValue, language: language ?? "eng")
    }
}
