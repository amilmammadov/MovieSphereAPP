//
//  MLeftImageRightInfoCell.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.02.25.
//

import UIKit

class MLeftImageRightInfoCell: UITableViewCell {

    static let reuseId = "MLeftImageRightInfoCell"
    
    let topSpace = UIView()
    let movieImage = UIImageView()
    let genreImage = UIImageView(image: SFSymbols.ticket)
    let movieTitle = UILabel()
    var voteTitle = MLeftIconRightLabelView(icon: SFSymbols.star  ?? UIImage(), title: nil, color: Colors.starColor ?? UIColor(), font: 12)
    var releaseDateTitle = MLeftIconRightLabelView(icon: SFSymbols.calendar ?? UIImage(), title: nil, color: UIColor.white, font: 12)
    let bottomSpace = UIView()
    
    var genresLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(movie: MovieDetailModel, genreList: [String]){
        
        movieImage.loadUrl(path: movie.posterPath ?? "")
        movieTitle.text = movie.title
        voteTitle.titleLabel.text = String(movie.voteAverage ?? 0)
        releaseDateTitle.titleLabel.text = movie.releaseDate
        if genreList.count == 1 {
            genresLabel.text = genreList[0]
        }else if genreList.count > 1 {
            genresLabel.text =  genreList[0] + String(repeating: "   ", count: 3) +  genreList[1]
        }
    }
    
    private func configure(){
        
        backgroundColor = Colors.backGround
        
        addSubviews(topSpace, movieImage, movieTitle, voteTitle, genreImage, genresLabel, releaseDateTitle, bottomSpace)
        
        movieImage.layer.cornerRadius = 12
        movieImage.layer.masksToBounds = true
        
        movieTitle.textColor = .white
        movieTitle.font = UIFont(name: MFont.poppinsRegular, size: 16)
        
        topSpace.backgroundColor = Colors.backGround
        bottomSpace.backgroundColor = Colors.backGround
        
        genresLabel.textColor = UIColor.white
        genresLabel.font = UIFont(name: MFont.poppinsRegular, size: 12)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            topSpace.topAnchor.constraint(equalTo: self.topAnchor),
            topSpace.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topSpace.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topSpace.heightAnchor.constraint(equalToConstant: 10),
            
            movieImage.topAnchor.constraint(equalTo: topSpace.bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: bottomSpace.topAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 96),
            movieImage.heightAnchor.constraint(equalToConstant: 120),
            
            movieTitle.topAnchor.constraint(equalTo: topSpace.bottomAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieTitle.heightAnchor.constraint(equalToConstant: 24),
          
            voteTitle.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            voteTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            voteTitle.bottomAnchor.constraint(equalTo: genreImage.topAnchor, constant: -4),
            voteTitle.heightAnchor.constraint(equalToConstant: 20),
          
            genreImage.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            genreImage.bottomAnchor.constraint(equalTo: releaseDateTitle.topAnchor, constant: -4),
            genreImage.heightAnchor.constraint(equalToConstant: 16),
            genreImage.widthAnchor.constraint(equalToConstant: 16),
            
            genresLabel.centerYAnchor.constraint(equalTo: genreImage.centerYAnchor),
            genresLabel.leadingAnchor.constraint(equalTo: genreImage.trailingAnchor, constant: 4),
            genresLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            genresLabel.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateTitle.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            releaseDateTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            releaseDateTitle.bottomAnchor.constraint(equalTo: bottomSpace.topAnchor),
            releaseDateTitle.heightAnchor.constraint(equalToConstant: 20),
           
            bottomSpace.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            bottomSpace.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomSpace.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomSpace.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}
