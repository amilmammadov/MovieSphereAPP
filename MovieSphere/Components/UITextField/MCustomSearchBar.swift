//
//  MCustomSearchBar.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

final class MCustomSearchBar: MTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLeftView()
        configureRightView()
        configureSearchBarPlaceHolder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSearchBarPlaceHolder(){
        
        textColor = .white
        
        placeholder = ConstantStrings.searchPlaceHolder.localize
        
        let attributes: [NSAttributedString.Key:Any] = [.foregroundColor: Colors.seacrhIcon ?? UIColor()]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
    
    private func configureRightView(){
        
        let rightImageView = UIImageView(image: SFSymbols.searchTextFieldIcon)
        rightImageView.tintColor = Colors.seacrhIcon
        rightImageView.frame = CGRect(x: 12, y: 12, width: 20, height: 20)
        rightImageView.contentMode = .scaleAspectFit
        
        let rightContinerView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        rightContinerView.addSubview(rightImageView)
        
        rightView = rightContinerView
        rightViewMode = .always
    }
    private func configureLeftView(){
        
        let leftView = UIView(frame: CGRect(x: 20, y: 0, width: 20, height: 44))
        
        self.leftView = leftView
        leftViewMode = .always
        
    }
}
