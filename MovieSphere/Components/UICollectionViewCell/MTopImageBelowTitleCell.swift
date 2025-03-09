//
//  MTopImageBelowTitleCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 04.02.25.
//

import UIKit

final class MTopImageBelowTitleCell: UICollectionViewCell {
    
    static let reuseId = "MTopImageBelowTitleCell"
    
    private let imageView = UIImageView()
    private let titleLabel = MTitleLabel(text: nil, font: MFont.poppinsMedium, size: 12, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(actor: Actor){
        
        if let actorProfilePath = actor.profilePath {
            imageView.loadUrl(path: actorProfilePath)
        }else {
            imageView.image = SFSymbols.defaultProfile
        }
        
        titleLabel.text = actor.originalName
    }
    
    private func configure(){
        
        backgroundColor = Colors.backGround
        
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        titleLabel.numberOfLines = 2
    }
    
    private func addSubviews(){
        
        addSubviews(imageView, titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
