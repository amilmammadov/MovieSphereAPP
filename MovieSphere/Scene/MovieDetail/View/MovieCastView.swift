//
//  MovieCastView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 04.02.25.
//

import UIKit

class MovieCastView: UIView {
    
    var castCollection: UICollectionView!
    var movieCast: [Actor]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCastCollection()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(movieCast: [Actor]){
        self.init(frame: .zero)
        
        self.movieCast = movieCast
    }
    
    private func configureCastCollection(){
        
        castCollection = UICollectionView(frame: .zero, collectionViewLayout: createCastCollectionLayout())
        castCollection.backgroundColor = Colors.backGround
        castCollection.showsVerticalScrollIndicator = false
        castCollection.configure(self, MTopImageBelowTitleCell.self, MTopImageBelowTitleCell.reuseId)
    }
    
    private func createCastCollectionLayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 64
        return layout
    }
    
    private func configure(){
        
        backgroundColor = Colors.backGround
        
        addSubview(castCollection)
        castCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            castCollection.topAnchor.constraint(equalTo: self.topAnchor),
            castCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 32),
            castCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            castCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension MovieCastView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieCast?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = castCollection.dequeueReusableCell(withReuseIdentifier: MTopImageBelowTitleCell.reuseId, for: indexPath) as! MTopImageBelowTitleCell
        cell.setData(actor: movieCast?[indexPath.item] ?? Actor(originalName: nil, profilePath: nil))
        return cell
    }
}

extension MovieCastView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.size.width - 64) / 2, height: 128)
    }
}
