//
//  MTitleLabel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

class MTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(text: String?, font: String, size: CGFloat, textAlignment: NSTextAlignment){
        self.init()
        self.text = text
        self.font = UIFont(name: font, size: size)
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
