//
//  MovieDetailManagerProtocol.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

protocol MovieDetailManagerProtocol {
    func getMovieDetail(id: Int, completion: @escaping ((Result<MovieDetailModel, NetworkError>)->Void))
    func getReviesForMovie(id: Int, completion: @escaping ((Result<ReviewsModel, NetworkError>)->Void))
    func getMovieCast(id: Int, completion: @escaping ((Result<MovieCastModel, NetworkError>)->Void))
}
