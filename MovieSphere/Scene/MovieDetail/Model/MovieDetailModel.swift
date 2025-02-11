//
//  MovieDetailModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation


struct MovieDetailModel:Codable, Hashable {
   
    let id: Int?
    let backdropPath: String?
    let originalLanguage: String?
    let title: String?
    let runtime: Int?
    let voteAverage: Double?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let genres: [GenreNames]?
    
    enum CodingKeys: String, CodingKey{
        case id, title, runtime, overview, genres
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    init(id: Int? = nil, backdropPath: String? = nil, originalLanguage: String? = nil, title: String? = nil, runtime: Int? = nil, voteAverage: Double? = nil, posterPath: String? = nil, overview: String? = nil, releaseDate: String? = nil, genres: [GenreNames]? = nil) {
        self.id = id
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.title = title
        self.runtime = runtime
        self.voteAverage = voteAverage
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genres = genres
    }
    
    func convertToDictionary()->[String: Any] {
        return [
            "id":id ?? "",
            "backdropPath":backdropPath ?? "",
            "originalLanguage":originalLanguage ?? "",
            "title":title ?? "",
            "runtime":runtime ?? "",
            "voteAverage":voteAverage ?? 0,
            "posterPath":posterPath ?? "",
            "overview":overview ?? "",
            "releaseDate":releaseDate ?? "",
            "genres": genres?.map { $0.convertToDictionary() } ?? []
        ]
    }
}

struct GenreNames:Codable, Hashable {
    let id: Int?
    let name: String?
    
    func convertToDictionary()->[String:Any]{
        return [
            "id":id ?? "",
            "name":name ?? ""
        ]
    }
}

