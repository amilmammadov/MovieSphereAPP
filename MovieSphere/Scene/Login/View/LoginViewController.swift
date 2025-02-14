//
//  LoginViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 11.02.25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let posterImage = UIImageView()
    let titleLabel = MTitleLabel(text: ConstantStrings.loginPageText, font: MFont.poppinsSemiBold, size: 24, textAlignment: .center)
    let continueButton = UIButton()
    let loginOptionsViewController = LoginOptionsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLoginViewController()
        addSubviews()
        configureUIComponents()
    }
    
    private func configureLoginViewController(){
        
        view.backgroundColor = Colors.backGround
    }
    
    private func configureUIComponents(){
        
        posterImage.image = SFSymbols.popcorn
        
        titleLabel.numberOfLines = 3
        
        continueButton.backgroundColor = .red
        continueButton.layer.cornerRadius = 16
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.textColor = .white
        continueButton.titleLabel?.font = UIFont(name: MFont.poppinsSemiBold, size: 20)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped(){
        
        presentModalViewController(loginOptionsViewController)
    }
    
    private func addSubviews(){
        
        view.addSubviews(posterImage, titleLabel, continueButton)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * 0.16),
            posterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 160),
            posterImage.widthAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 72),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            continueButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
    }

}
