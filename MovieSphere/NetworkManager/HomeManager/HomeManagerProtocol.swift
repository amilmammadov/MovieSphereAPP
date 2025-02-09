//
//  HomeManagerProtocol.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

protocol HomeManagerProtocol {
    func getHomePageMovies(category: Category, page: Int, completion: @escaping ((Result<MovieModel, NetworkError>)->Void))
}
