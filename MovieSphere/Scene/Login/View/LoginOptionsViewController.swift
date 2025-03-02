//
//  LoginOptionsViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 11.02.25.
//

import UIKit

final class LoginOptionsViewController: UIViewController {
    
    private let googleLogin = MLoginOptionView(image: SFSymbols.googleLogo ?? UIImage(), title: ConstantStrings.continueWithGoogle, color: .white, textColor: .black)
    private let appleLogin = MLoginOptionView(image: SFSymbols.appleLogo ?? UIImage(), title: ConstantStrings.continueWithApple, color: .black, textColor: .white)
    private let facebookLogin = MLoginOptionView(image: SFSymbols.facebookLogo ?? UIImage(), title: ConstantStrings.continueWithFacebook, color: Colors.facebookLoginBackground ?? UIColor(), textColor: .white)
    
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.searchTextFieldBackGround
        loginViewModel.loginAdapter = LoginAdapter(controller: self)
        
        addSubviews()
        configure()
    }
    
    private func configure(){
        
        let tapGestureForGoogleLogin = UITapGestureRecognizer(target: self, action: #selector(googleLoginViewTapped))
        googleLogin.addGestureRecognizer(tapGestureForGoogleLogin)
        googleLogin.isUserInteractionEnabled = true
        
        let tapGestureForAppleLogin = UITapGestureRecognizer(target: self, action: #selector(appleLoginViewTapped))
        appleLogin.addGestureRecognizer(tapGestureForAppleLogin)
        appleLogin.isUserInteractionEnabled = true
        
        let tapGestureForFacebookLogin = UITapGestureRecognizer(target: self, action: #selector(facebookLoginViewTapped))
        facebookLogin.addGestureRecognizer(tapGestureForFacebookLogin)
        facebookLogin.isUserInteractionEnabled = true
    }
    
    @objc func googleLoginViewTapped(){
        
        loginViewModel.login(loginType: .google)
        loginViewModel.successCallBackForLogin = {user in

            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.appCoordinator?.putMainPageToRoot()
            }
        }
        loginViewModel.errorCallBackForLogin = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
    }
    
    @objc func appleLoginViewTapped(){
        
        loginViewModel.errorCallBackForLogin = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
        loginViewModel.login(loginType: .apple)
    }
    
    @objc func facebookLoginViewTapped(){
        
        loginViewModel.errorCallBackForLogin = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
        loginViewModel.login(loginType: .facebook)
    }
    
    private func addSubviews(){
        
        view.addSubviews(googleLogin, appleLogin, facebookLogin)
        
        NSLayoutConstraint.activate([
            googleLogin.bottomAnchor.constraint(equalTo: appleLogin.topAnchor, constant: -20),
            googleLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleLogin.heightAnchor.constraint(equalToConstant: 52),
            googleLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.76),
            
            appleLogin.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appleLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleLogin.heightAnchor.constraint(equalToConstant: 52),
            appleLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.76),
            
            facebookLogin.topAnchor.constraint(equalTo: appleLogin.bottomAnchor, constant: 20),
            facebookLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLogin.heightAnchor.constraint(equalToConstant: 52),
            facebookLogin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.76)
        ])
    }
}
