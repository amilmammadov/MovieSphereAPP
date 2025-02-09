//
//  PersistanceError.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 08.02.25.
//

import Foundation

enum PersistanceError: String,Error {
    case unableToAddFavorites = "The problem occured when adding to favorites!"
    case unableToRetrieve = "The problem occured  when getting favorited movies!"
    case duplicate = "You have already added this movie to favorites!"
}
