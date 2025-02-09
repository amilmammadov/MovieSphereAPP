//
//  SearchManagerProtocol.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

protocol SearchManagerProtocol {
    func getSearchPageDefaultData(category: Category, page: Int, completion: @escaping ((Result<MovieModel, NetworkError>)->Void))
    func getGenreList(completion: @escaping ((Result<GenreModel, NetworkError>)->Void))
    func getSearchedMovie(queryParam: String, completion: @escaping ((Result<MovieModel, NetworkError>)->Void))
}
