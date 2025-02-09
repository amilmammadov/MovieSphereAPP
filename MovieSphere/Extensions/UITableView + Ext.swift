//
//  UITableView + ext.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.02.25.
//

import UIKit

extension UITableView {
    func configure<T:UITableViewCell>(_ delegate: UITableViewDelegate & UITableViewDataSource, _ cell: T.Type, _ identifier: String){
        self.dataSource = delegate
        self.delegate = delegate
        self.register(cell, forCellReuseIdentifier: identifier)
    }
}
