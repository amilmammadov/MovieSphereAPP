//
//  ReviewsModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 02.02.25.
//

import Foundation

struct ReviewsModel:Codable {
    let id: Int?
    let page: Int?
    let results: [Review]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
    }
}

struct Review:Codable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case author, content
        case authorDetails = "author_details"
    }
}

struct AuthorDetails:Codable {
    let name: String?
    let avatarpath: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey{
        case name, rating
        case avatarpath = "avatar_path"
    }
}
