//
//  LoginOptionsViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 11.02.25.
//

import UIKit

class LoginOptionsViewController: UIViewController {
    
    let googleLogin = MLoginOptionView(image: SFSymbols.googleLogo ?? UIImage(), title: ConstantStrings.signInWithGoogle, color: .white, textColor: .black)
    let appleLogin = MLoginOptionView(image: SFSymbols.appleLogo ?? UIImage(), title: ConstantStrings.signInWithApple, color: .black, textColor: .white)
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.searchTextFieldBackGround
        loginViewModel.loginAdapter = LoginAdapter(controller: self)
        
        addSubviews()
        configure()
    }
    
    private func configure(){
        
        let panGestureForGoogleLogin = UITapGestureRecognizer(target: self, action: #selector(googleLoginViewTapped))
        googleLogin.addGestureRecognizer(panGestureForGoogleLogin)
        googleLogin.isUserInteractionEnabled = true
        
        let panGestureForAppleLogin = UITapGestureRecognizer(target: self, action: #selector(appleLoginViewTapped))
        appleLogin.addGestureRecognizer(panGestureForAppleLogin)
        appleLogin.isUserInteractionEnabled = true
    }
    
    @objc func googleLoginViewTapped(){
        
        loginViewModel.login(loginType: .google)
        loginViewModel.successCallBackForLogin = {user in
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.putMainPageToRoot()
            }
        }
    }
    
    @objc func appleLoginViewTapped(){
        
        loginViewModel.login(loginType: .apple)
    }
    
    private func addSubviews(){
        
        view.addSubviews(googleLogin, appleLogin)
        
        googleLogin.translatesAutoresizingMaskIntoConstraints = false
        appleLogin.translatesAutoresizingMaskIntoConstraints = false
        
        let padding :CGFloat = (view.frame.size.height * 0.5) - ((view.frame.size.height * 0.32) - 26)
        
        NSLayoutConstraint.activate([
            googleLogin.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -padding),
            googleLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleLogin.heightAnchor.constraint(equalToConstant: 52),
            googleLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
            
            appleLogin.topAnchor.constraint(equalTo: googleLogin.bottomAnchor, constant: 20),
            appleLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleLogin.heightAnchor.constraint(equalToConstant: 52),
            appleLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72)
        ])
    }
}
