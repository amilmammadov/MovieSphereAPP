//
//  UIViewController + Ext.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func showLoading(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        view.bringSubviewToFront(containerView)
        containerView.backgroundColor = Colors.backGround?.withAlphaComponent(0.75)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    func dismissLoading(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
        }
    }
    
    func presentAlertOnMainThread(with message: String){
        
        DispatchQueue.main.async {
            let alertViewController = MAlertViewController(with: message)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
            
            alertViewController.view.alpha = 0
            
            UIView.animate(withDuration: 1, animations: {
                alertViewController.view.alpha = 1
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    alertViewController.dismiss(animated: true)
                })
            })
        }
    }
}
