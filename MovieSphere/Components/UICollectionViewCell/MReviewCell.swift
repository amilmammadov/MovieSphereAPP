//
//  MReviewCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 02.02.25.
//

import UIKit

class MReviewCell: UICollectionViewCell {
    
    static let reuseId = "MReviewCell"
    
    let profileImageView = UIImageView()
    let ratingByReviewer = MTitleLabel(text: nil, font: MFont.poppinsMedium, size: 12, textAlignment: .center)
    let reviewerTitle = MTitleLabel(text: nil, font: MFont.poppinsMedium, size: 12, textAlignment: .left)
    let reviewTitle = MTitleLabel(text: nil, font: MFont.poppinsRegular, size: 12, textAlignment: .justified)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubvies()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(review: Review){
        
        if let avatarPath = review.authorDetails?.avatarpath {
            profileImageView.loadUrl(path: avatarPath)
        }else{
            profileImageView.image = SFSymbols.defaultProfile
        }
        
        ratingByReviewer.text = String(review.authorDetails?.rating ?? 0)
        reviewerTitle.text  = review.author
        reviewTitle.text = review.content
    }
    
    private func configure(){
        
        profileImageView.layer.cornerRadius = 22
        profileImageView.clipsToBounds = true
        
        
        ratingByReviewer.textColor = Colors.reviewerRating
        
        reviewTitle.numberOfLines = 4
    }
    
    private func addSubvies(){
        
        addSubviews(profileImageView, reviewerTitle, ratingByReviewer, reviewTitle)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        reviewTitle.translatesAutoresizingMaskIntoConstraints = false
        reviewerTitle.translatesAutoresizingMaskIntoConstraints = false
        ratingByReviewer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 44),
            profileImageView.heightAnchor.constraint(equalToConstant: 44),
            
            reviewerTitle.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            reviewerTitle.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            reviewerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            reviewerTitle.heightAnchor.constraint(equalToConstant: 20),
            
            ratingByReviewer.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            ratingByReviewer.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            ratingByReviewer.heightAnchor.constraint(equalToConstant: 20),
            ratingByReviewer.widthAnchor.constraint(equalToConstant: 44),
            
            reviewTitle.topAnchor.constraint(equalTo: reviewerTitle.bottomAnchor, constant: 4),
            reviewTitle.leadingAnchor.constraint(equalTo: reviewerTitle.leadingAnchor),
            reviewTitle.trailingAnchor.constraint(equalTo: reviewerTitle.trailingAnchor),
            reviewTitle.heightAnchor.constraint(equalToConstant: 72)
            
        ])
    }
}
