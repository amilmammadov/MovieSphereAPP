//
//  GenreModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

struct GenreModel:Codable {
    let genres:[Genre]?
}
struct Genre:Codable {
    let id: Int?
    let name: String?
}
