//
//  MTextField.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

class MTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        
        layer.cornerRadius = 16
        backgroundColor = Colors.searchTextFieldBackGround
        translatesAutoresizingMaskIntoConstraints = false
    }
}
