//
//  NetworkError.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

enum NetworkError:String, Error {
    case invalidUrl = "There is not exact match with your request!"
    case encodingError = "The problem occured when creating request!"
    case unableToComplete = "The problem occured with your request. Please check your network!"
    case invalidData = "Invalid response from server. Please try again!"
    case noContent = "There is not that kind of data!"
}
