//
//  File.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadUrl(path: String){
        let baseImageUrl: String = "https://image.tmdb.org/t/p/original"
        if let url = URL(string: baseImageUrl + path) {
            self.sd_setImage(with: url)
        }
    }
    
    func loadProfile(path: String){
        if let url = URL(string: path) {
            self.sd_setImage(with: url)
        }
    }
}
