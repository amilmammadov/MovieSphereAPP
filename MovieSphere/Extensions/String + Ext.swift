//
//  String + Ext.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 15.02.25.
//

import Foundation

extension String {
    var localize: String {
        
        let language = UserDefaults.standard.string(forKey: Language.key.rawValue)
        let path = Bundle.main.path(forResource: language, ofType: "lproj") ?? ""
        let bundle = Bundle(path: path) ?? Bundle()
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
