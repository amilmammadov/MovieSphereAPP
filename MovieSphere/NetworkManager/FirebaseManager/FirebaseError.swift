//
//  FirebaseError.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 10.02.25.
//

import Foundation

enum FirebaseError: String, Error {
    
    case unableToAddMovie = "The problem occured when trying to add movie to favorites"
    case checkError = "The problem occured. Please try again!"
    case isNotFavorited
    case fetchDataError = "The problem occured when trying to fetch data. Please try again!"
    case noData
    case unableToRemove = "The problem occured when trying to remove movie from favorites!"
}
