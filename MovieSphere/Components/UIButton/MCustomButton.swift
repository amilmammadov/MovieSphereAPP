//
//  MButton.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 02.02.25.
//

import UIKit

class MCustomButton: UIButton {
    
    let bottomLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, font: String, size: CGFloat){
        self.init(frame: .zero)
        
        setTitle(title, for:.normal)
        titleLabel?.font = UIFont(name: font, size: size)
        
    }
    
    private func configure(){
        
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBottomLine(){
        
        addSubview(bottomLine)
       
        bottomLine.layer.cornerRadius = 8
        bottomLine.backgroundColor = Colors.searchTextFieldBackGround
       
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            
           bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
           bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
           bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
           bottomLine.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
