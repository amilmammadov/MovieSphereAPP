//
//  TestView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 03.02.25.
//

import UIKit

final class ReviewsView: UIView {
    
    private var movieReviews: [Review]?
    private lazy var reviewsCollection: UICollectionView = {
        let reviewsCollection = UICollectionView(frame: .zero, collectionViewLayout: createReviewsCollectionLayout())
        reviewsCollection.backgroundColor = Colors.backGround
        reviewsCollection.delegate = self
        reviewsCollection.dataSource = self
        reviewsCollection.register(MReviewCell.self, forCellWithReuseIdentifier: MReviewCell.reuseId)
        return reviewsCollection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(reviews: [Review]){
        self.init(frame: .zero)
        
        movieReviews = reviews
    }
    
    private func createReviewsCollectionLayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing  = 12
        return layout
    }
    
    private func configure(){
        
        backgroundColor = Colors.backGround
        
        addSubview(reviewsCollection)
        reviewsCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewsCollection.topAnchor.constraint(equalTo: self.topAnchor),
            reviewsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            reviewsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            reviewsCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}

extension ReviewsView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieReviews?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = reviewsCollection.dequeueReusableCell(withReuseIdentifier: MReviewCell.reuseId, for: indexPath) as! MReviewCell
        cell.setData(review: movieReviews?[indexPath.row] ?? Review(author: nil, authorDetails: nil, content: nil))
        return cell
    }
}

extension ReviewsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width - 48, height: 112)
    }
}
