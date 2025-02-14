//
//  MLoginOptionView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 13.02.25.
//

import UIKit

class MLoginOptionView: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage, title: String, color: UIColor, textColor: UIColor){
        self.init(frame: .zero)
        
        imageView.image = image
        titleLabel.text = title
        titleLabel.textColor = textColor
        backgroundColor = color
    }
    
    private func configure(){
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: MFont.poppinsRegular, size: 20)
    }
    
    private func addSubviews(){
        
        addSubviews(imageView,titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 52),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
