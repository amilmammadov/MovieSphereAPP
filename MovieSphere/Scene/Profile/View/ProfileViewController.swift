//
//  ProfileViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 15.02.25.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    let profileImage = UIImageView()
    let fullNameLabel = MTitleLabel(text: nil, font: MFont.poppinsRegular, size: 20, textAlignment: .left)
    let emailLabel = MTitleLabel(text: nil, font: MFont.poppinsRegular, size: 20, textAlignment: .left)
    let logoutView = UIView()
    
    let languageStackView = UIStackView()
    
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cofigure()
        addSubviews()
        configureLanguageStackView()
        configureLogOutView()
        configureUIcomponents()
    }
    
    private func cofigure(){
        
        profileViewModel.successCallBackForProfile = { [weak self] user in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let path = user.profileImageUrl {
                    self.profileImage.loadProfile(path: path)
                }else{
                    self.profileImage.image = SFSymbols.defaultProfile
                }
                self.fullNameLabel.text = "   " + user.name
                self.emailLabel.text = "   " + user.email
            }
        }
        
        profileViewModel.errorCallBackForProfile = { [weak self] error in
            guard let self = self else { return }
            self.presentAlertOnMainThread(with: error)
        }
        
        profileViewModel.retrieveData()
    }
    
    private func addSubviews(){
        
        view.addSubviews(languageStackView ,profileImage, fullNameLabel, emailLabel, logoutView)
        
        NSLayoutConstraint.activate([
            languageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            languageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            languageStackView.heightAnchor.constraint(equalToConstant: 44),
            languageStackView.widthAnchor.constraint(equalToConstant: 100),
            
            profileImage.topAnchor.constraint(equalTo: languageStackView.bottomAnchor, constant: 40),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 140),
            profileImage.widthAnchor.constraint(equalToConstant: 140),
            
            fullNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 32),
            fullNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 44),
            fullNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            emailLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 44),
            emailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            logoutView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40),
            logoutView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutView.heightAnchor.constraint(equalToConstant: 36),
            logoutView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
        ])
    }
    
    private func configureUIcomponents(){
        
        profileImage.layer.cornerRadius = 70
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleToFill
        
        fullNameLabel.backgroundColor = Colors.searchTextFieldBackGround
        fullNameLabel.textColor = .white
        fullNameLabel.layer.cornerRadius = 16
        fullNameLabel.clipsToBounds = true
        fullNameLabel.adjustsFontSizeToFitWidth = true
        
        emailLabel.backgroundColor = Colors.searchTextFieldBackGround
        emailLabel.textColor = .white
        emailLabel.layer.cornerRadius = 16
        emailLabel.clipsToBounds = true
        emailLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureLanguageStackView(){
        
        let engLangButton = UIButton()
        engLangButton.setTitle(" ENG ", for: .normal)
        engLangButton.backgroundColor = .systemBlue
        engLangButton.layer.cornerRadius = 12
        engLangButton.setTitleColor(.white, for: .normal)
        engLangButton.addTarget(self, action: #selector(engLangButtonTapped), for: .touchUpInside)
        
        let rusLangButton = UIButton()
        rusLangButton.setTitle(" RUS ", for: .normal)
        rusLangButton.backgroundColor = .systemRed
        rusLangButton.layer.cornerRadius = 12
        rusLangButton.setTitleColor(.white, for: .normal)
        rusLangButton.addTarget(self, action: #selector(rusLangButtonTapped), for: .touchUpInside)
        
        languageStackView.addArrangedSubview(engLangButton)
        languageStackView.addArrangedSubview(rusLangButton)
        languageStackView.axis = .horizontal
        languageStackView.distribution = .equalSpacing
    }
    
    @objc func engLangButtonTapped(){
        
        setLanguageAndReload(staticStringsLanguage:Language.eng.rawValue, apiQuerylanguage: "en-US")
    }
    
    @objc func rusLangButtonTapped(){
        
        setLanguageAndReload(staticStringsLanguage:Language.rus.rawValue, apiQuerylanguage: "ru-RU")
    }
    
    private func setLanguageAndReload(staticStringsLanguage: String, apiQuerylanguage: String){
        
        UserDefaults.standard.set(apiQuerylanguage, forKey: ConstantStrings.selectedLanguage)
        UserDefaults.standard.set(staticStringsLanguage, forKey: Language.key.rawValue)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.reload()
        }
    }
    private func configureLogOutView(){
        
        let titleLabel = MTitleLabel(text: "logout".localize, font: MFont.poppinsRegular, size: 24, textAlignment: .center)
        
        let logoutIcon = UIImageView(image: SFSymbols.logout)
        logoutIcon.tintColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoutViewTapped))
        logoutView.addGestureRecognizer(tapGesture)
        logoutView.isUserInteractionEnabled = true
        
        logoutView.addSubviews(titleLabel, logoutIcon)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: logoutView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: logoutIcon.leadingAnchor, constant: 4),
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
            
            logoutIcon.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutIcon.trailingAnchor.constraint(equalTo: logoutView.trailingAnchor),
            logoutIcon.heightAnchor.constraint(equalToConstant: 28),
            logoutIcon.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    @objc func logoutViewTapped(){
        
        GIDSignIn.sharedInstance.signOut()
        UserDefaults.standard.removeObject(forKey: LoginType.google.rawValue)
        if let sceneDeleate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDeleate.putLoginPageToRoot()
        }
    }
}
