//
//  MEmptySpaceView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import UIKit

class MEmptySpaceView: UIView {
    
    let imageView = UIImageView()
    let titleLabel = MTitleLabel(text: nil, font: MFont.poppinsSemiBold, size: 16, textAlignment: .center)
    let subTitleLabel = MTitleLabel(text: nil, font: MFont.poppinsMedium, size: 12, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage, title: String, subTitle: String){
        self.init(frame: .zero)
        
        imageView.image = image
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    private func configure(){
        
        addSubviews(imageView, titleLabel, subTitleLabel)
        
        backgroundColor = Colors.backGround
        
        titleLabel.textColor = .white
        subTitleLabel.textColor = Colors.seacrhIcon
        
        titleLabel.numberOfLines = 2
        subTitleLabel.numberOfLines = 2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60),
            imageView.heightAnchor.constraint(equalToConstant: 76),
            imageView.widthAnchor.constraint(equalToConstant: 76),
            
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            titleLabel.widthAnchor.constraint(equalToConstant: 252),
            
            subTitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 36),
            subTitleLabel.widthAnchor.constraint(equalToConstant: 252)
        ])
    }
}
