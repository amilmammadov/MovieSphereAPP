//
//  HomeManager.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getHomePageMovies(category: Category, page: Int, completion: @escaping ((Result<MovieModel, NetworkError>)->Void)){
        var url:String = ""
        
        switch category {
        case .nowPlaying:
            url = HomeEndPoints.nowPlaying.path
        case .upComing:
            url = HomeEndPoints.upComing.path
        case .topRated:
            url = HomeEndPoints.topRated.path
        case .popular:
            url = HomeEndPoints.popular.path
        }
        
        NetworkManager.shared.request(model: MovieModel.self, url: url + "&page=\(page)", completion: completion)
    }
}
