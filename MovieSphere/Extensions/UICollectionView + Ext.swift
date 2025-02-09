//
//  UICollectionView + Ext.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 28.01.25.
//

import UIKit

extension UICollectionView {
    func configure<T: UICollectionViewCell>(_ delegate: UICollectionViewDelegate & UICollectionViewDataSource,_ cell: T.Type,_ identifier: String){
        self.dataSource = delegate
        self.delegate = delegate
        self.register(cell, forCellWithReuseIdentifier: identifier)
    }
}
