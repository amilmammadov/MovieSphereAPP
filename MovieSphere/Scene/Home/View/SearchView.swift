//
//  SearchView.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 08.02.25.
//

import UIKit

protocol SearchViewDelegate{
    func didMovieTapped(movieId: Int)
}

class SearchView: UIView {
    
    var searchCollection: UICollectionView!
    var movies = [Movie]()
    var genreList = [[String]]()
    
    var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.backGround
        configureSearchCollection()
        configureSearchView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSearchView(){
        
        addSubview(searchCollection)
        searchCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchCollection.topAnchor.constraint(equalTo: self.topAnchor),
            searchCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureSearchCollection(){
        
        searchCollection = UICollectionView(frame: .zero, collectionViewLayout: createSearchCollectionLayout())
        searchCollection.backgroundColor = Colors.backGround
        searchCollection.configure(self, MLeftImageRightDetailCell.self, MLeftImageRightDetailCell.reuseId)
    }
    
    private func createSearchCollectionLayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: 120)
        layout.minimumLineSpacing = 20
        return layout
    }
}

extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: MLeftImageRightDetailCell.reuseId, for: indexPath) as! MLeftImageRightDetailCell
        cell.setData(movie: movies[indexPath.row], genreList: genreList[indexPath.row])
        cell.genreCollection.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didMovieTapped(movieId: movies[indexPath.row].id ?? 0)
    }
}
