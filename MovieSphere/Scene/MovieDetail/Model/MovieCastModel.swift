//
//  MovieCastModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 04.02.25.
//

import Foundation

struct MovieCastModel:Codable {
    let id: Int?
    let cast: [Actor]?
}

struct Actor:Codable {
    let  originalName : String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case profilePath =  "profile_path"
    }
}
