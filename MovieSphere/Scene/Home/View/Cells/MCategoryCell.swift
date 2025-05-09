//
//  MCategoryCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 28.01.25.
//

import UIKit

final class MCategoryCell: UICollectionViewCell {
    
    static let reuseId = "MCategoryCell"
    
    private let categoryLabel = MTitleLabel(text: nil, font: MFont.poppinsMedium, size: 14,textAlignment: .center)
    let bottomLine = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String){
        categoryLabel.text = title
    }
    private func configure(){
        
        addSubviews(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addBottomLineToCell(){
         
         addSubview(bottomLine)
        
         bottomLine.layer.cornerRadius = 8
        bottomLine.backgroundColor = Colors.searchTextFieldBackGround
        
         bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
         NSLayoutConstraint.activate([
            
            bottomLine.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 4)
         ])
    }
}
