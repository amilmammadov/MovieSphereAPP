//
//  UIView + Ext.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...){
        for view in views { self.addSubview(view)}
    }
}
