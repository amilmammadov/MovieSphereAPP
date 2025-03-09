//
//  SingleImageCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

final class MSingleImageCell: UICollectionViewCell {
    
    static let reuseId = "MSingleImageCell"
    private let posterImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: self.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func set(movie: Movie){
        posterImage.loadUrl(path: movie.posterPath ?? "")
    }
}
