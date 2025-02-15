//
//  MAlertViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.02.25.
//

import UIKit

class MAlertViewController: UIViewController {
    
    let messageLabel = MTitleLabel(text: nil, font: MFont.poppinsRegular, size: 20, textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    init(with title: String){
        super.init(nibName: nil, bundle: nil)
        
        messageLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        view.addSubview(messageLabel)
        
        messageLabel.numberOfLines = 2
        messageLabel.backgroundColor = .systemRed
        messageLabel.layer.cornerRadius = 16
        messageLabel.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
