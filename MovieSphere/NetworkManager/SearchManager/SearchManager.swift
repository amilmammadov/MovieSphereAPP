//
//  SearchManager.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

class SearchManager: SearchManagerProtocol {
    static let shared = SearchManager()
    
    func getSearchPageDefaultData(category: Category,page: Int, completion: @escaping ((Result<MovieModel, NetworkError>)->Void)){
        NetworkManager.shared.request(model: MovieModel.self, url: SearchEndPoints.popular.path + "&page=\(page)", completion: completion)
    }
    
    func getGenreList(completion: @escaping ((Result<GenreModel, NetworkError>)->Void)){
        NetworkManager.shared.request(model: GenreModel.self, url: SearchEndPoints.genreList.path, completion: completion)
    }
    
    func getSearchedMovie(queryParam: String, completion: @escaping ((Result<MovieModel, NetworkError>)->Void)){
        
        var newGeneratedParam = ""
        if let generatedParam = queryParam.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            newGeneratedParam = generatedParam
        }else {
            newGeneratedParam = queryParam
        }
        
        NetworkManager.shared.request(model: MovieModel.self, url: SearchEndPoints.searchMovie.path + "&query=\(newGeneratedParam)", completion: completion)
    }
}
