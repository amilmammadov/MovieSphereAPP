//
//  MLeftIconRightLabelView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import UIKit

final class MLeftIconRightLabelView: UIView {
    
    private let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(icon: UIImage, title: String?, color: UIColor, font: CGFloat){
        self.init(frame: .zero)
        
        imageView.image = icon
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.font = UIFont.systemFont(ofSize: font)
    }
    
    private func configure(){
        
        self.addSubviews(imageView, titleLabel)
        configureTitleLabel()
        
        NSLayoutConstraint.activate([
            
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4)
        ])
    }
    
    private func configureTitleLabel(){
        
        titleLabel.textAlignment = .left
    }
}
