//
//  MGenreCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import UIKit

class MGenreCell: UICollectionViewCell {
    
    static let reuseId = "MGenreCell"
    
    let genreLabel = MTitleLabel(text: nil, font: MFont.poppinsRegular, size: 12, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String){
        genreLabel.text = title
    }
    
    private func configure(){
        
        addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: self.topAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            genreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


