//
//  AboutMovieView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 04.02.25.
//

import UIKit

final class AboutMovieView: UIView {
    
    private let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(movieOverview: String){
        self.init(frame: .zero)
        
        textView.text = movieOverview
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        backgroundColor = Colors.backGround
        
        addSubview(textView)
        
        textView.textColor = .white
        textView.backgroundColor = Colors.backGround
        textView.textAlignment = .justified
        textView.font = UIFont(name: MFont.poppinsRegular, size: 12)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
