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
    
    func presentModalViewController(_ viewController: UIViewController){
        
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewController.view.layer.cornerRadius = 16
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_ :)))
        viewController.view.addGestureRecognizer(panGesture)
        
        let screenHeight = self.view.frame.size.height
        let modalViewHeight = screenHeight * 0.4
        let positionY = screenHeight - modalViewHeight
        viewController.view.frame = CGRect(x: 0, y: screenHeight, width: self.view.frame.size.width, height: modalViewHeight)
        
        viewController.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            viewController.view.frame = CGRect(x: 0, y: positionY , width: self.view.frame.size.width, height: modalViewHeight)
        })
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer){
        
        guard let modalView = self.view.subviews.last else { return }
        
        let translation = gesture.translation(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        let screenHeight = self.view.frame.size.height
        let modalViewHeight = screenHeight * 0.4
        
        switch gesture.state {
        case .changed:
            let newYPosition = max(screenHeight - modalViewHeight + translation.y, screenHeight - modalViewHeight)
            modalView.frame.origin.y = newYPosition
        case .ended:
            
            if translation.y > 100 || velocity.y > 500 {
                UIView.animate(withDuration: 0.1, animations: {
                    modalView.frame.origin.y = screenHeight
                }, completion: { _ in
                    modalView.removeFromSuperview()
                   self.children.last?.removeFromParent()
                })
            }else {
                UIView.animate(withDuration: 0.3, animations: {
                    modalView.frame.origin.y = screenHeight - modalViewHeight
                })
            }
        default:
            break
        }
    }
}
