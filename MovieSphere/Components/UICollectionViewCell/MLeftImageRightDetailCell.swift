//
//  LeftImageRightDetailCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 31.01.25.
//

import UIKit

class MLeftImageRightDetailCell: UICollectionViewCell {
    
    static let reuseId = "MLeftImageRightDetailCell"
    
    let movieImage = UIImageView()
    let genreImage = UIImageView(image: SFSymbols.ticket)
    let movieTitle = UILabel()
    var voteTitle = MLeftIconRightLabelView(icon: SFSymbols.star  ?? UIImage(), title: nil, color: Colors.starColor ?? UIColor(), font: 12)
    var releaseDateTitle = MLeftIconRightLabelView(icon: SFSymbols.calendar ?? UIImage(), title: nil, color: UIColor.white, font: 12)
    
    var genreCollection: UICollectionView!
    var genreNames: Array<String>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureGenreCollection()
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(movie: Movie, genreList: [String]){
        movieImage.loadUrl(path: movie.posterPath ?? "")
        movieTitle.text = movie.title
        voteTitle.titleLabel.text = String(movie.voteAverage!)
        releaseDateTitle.titleLabel.text = movie.releaseDate
        genreNames = genreList
    }
    
    private func configureGenreCollection(){
        genreCollection = UICollectionView(frame: .zero, collectionViewLayout: createGenreCollectionLayout())
        genreCollection.backgroundColor = Colors.backGround
        genreCollection.showsHorizontalScrollIndicator = false
        genreCollection.configure(self, MGenreCell.self, MGenreCell.reuseId)
    }
    
    private func createGenreCollectionLayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func configure(){
        
        addSubviews(movieImage, movieTitle, voteTitle, genreImage, genreCollection, releaseDateTitle)
        
        movieImage.layer.cornerRadius = 12
        movieImage.layer.masksToBounds = true
        
        movieTitle.textColor = .white
        movieTitle.font = UIFont(name: MFont.poppinsRegular, size: 16)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        genreImage.translatesAutoresizingMaskIntoConstraints = false
        voteTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseDateTitle.translatesAutoresizingMaskIntoConstraints = false
        genreCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 96),
            
            movieTitle.topAnchor.constraint(equalTo: movieImage.topAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieTitle.heightAnchor.constraint(equalToConstant: 24),
          
            voteTitle.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            voteTitle.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            voteTitle.bottomAnchor.constraint(equalTo: genreImage.topAnchor, constant: -4),
            voteTitle.heightAnchor.constraint(equalToConstant: 20),
            
            genreImage.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            genreImage.bottomAnchor.constraint(equalTo: releaseDateTitle.topAnchor, constant: -4),
            genreImage.heightAnchor.constraint(equalToConstant: 16),
            genreImage.widthAnchor.constraint(equalToConstant: 16),
            
            genreCollection.centerYAnchor.constraint(equalTo: genreImage.centerYAnchor),
            genreCollection.leadingAnchor.constraint(equalTo: genreImage.trailingAnchor, constant: 4),
            genreCollection.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            genreCollection.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateTitle.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            releaseDateTitle.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            releaseDateTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            releaseDateTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
extension MLeftImageRightDetailCell:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genreNames?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MGenreCell.reuseId, for: indexPath) as! MGenreCell
        cell.setData(title: genreNames?[indexPath.row] ?? "")
        return cell
    }
}

extension MLeftImageRightDetailCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (genreNames?[indexPath.item].count ?? 0) * 10
        return CGSize(width: width, height: 20)
    }
}
