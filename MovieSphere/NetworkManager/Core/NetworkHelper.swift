//
//  NetworkHelper.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseUrl: String = "https://api.themoviedb.org/3/"
    let apiKey: String = "ae0afa9860fb0a5dfff99d92680fd717"
    
    func urlConfig(path: String, language: String) -> String{
        return baseUrl + path + "?api_key=\(apiKey)&language=\(language)"
    }
}
