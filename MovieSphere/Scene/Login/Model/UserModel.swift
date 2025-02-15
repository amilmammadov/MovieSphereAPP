//
//  UserModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import Foundation

struct UserModel:Codable {
    let name:String
    let email:String
    let profileImageUrl: String?
}
