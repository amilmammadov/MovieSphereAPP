//
//  UIStackView + Ext.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 02.02.25.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: UIView...){
        for view in views { self.addArrangedSubview(view)}
    }
}
