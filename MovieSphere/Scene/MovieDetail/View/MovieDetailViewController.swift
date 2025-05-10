//
//  MovieDetailViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    private let backPosterImage = UIImageView()
    private let posterImage = UIImageView()
    private let titleLabel = MTitleLabel(text: nil, font: MFont.poppinsSemiBold, size: 18, textAlignment: .justified)
    private let voteAverageView = MLeftIconRightLabelView(icon: SFSymbols.star ?? UIImage(), title: nil, color: Colors.starColor ?? UIColor(), font: 16)
    
    private let releaseYearView = MLeftIconRightLabelView(icon: SFSymbols.calendar ?? UIImage(), title: nil, color: Colors.seacrhIcon ?? UIColor(), font: 12)
    private let runtimeView = MLeftIconRightLabelView(icon: SFSymbols.clock ?? UIImage(), title: nil, color: Colors.seacrhIcon ?? UIColor(), font: 12)
    private let separatorView = MSeperatorView()
    private let runtimeAndCalendarStack = UIStackView()
    
    private let aboutMovieButton = MCustomButton(title: ConstantStrings.aboutMovie.localize, font: MFont.poppinsMedium, size: 14)
    private let reviewsButton = MCustomButton(title: ConstantStrings.reviews.localize, font: MFont.poppinsMedium, size: 14)
    private let castButton = MCustomButton(title: ConstantStrings.cast.localize, font: MFont.poppinsMedium, size: 14)
    private let aboutReviewsCastStack = UIStackView()
    
    private let containerView = UIView()
    
    
    var movieDetailViewModel: MovieDetailViewModelProtocol?
    
    private var isMarkButtonTapped = false {
        didSet {
            let icon = isMarkButtonTapped ? SFSymbols.selectedMark : SFSymbols.unselectedMark
            navigationItem.rightBarButtonItem?.image = icon
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMovieDetailViewController()
        addSubviews()
        setConstraints()
        configureUIComponents()
        configureStackViews()
        configureData()
    }
    
    private func configureData(){
        
        showLoading()
        movieDetailViewModel?.getMovieDetail(id: movieDetailViewModel?.movieId ?? 0)
        movieDetailViewModel?.successCallBackForMovieDetail = {
            DispatchQueue.main.async {
                self.backPosterImage.loadUrl(path: self.movieDetailViewModel?.movieDetail?.backdropPath ?? "")
                self.voteAverageView.titleLabel.text = String(self.movieDetailViewModel?.movieDetail?.voteAverage ?? 0)
                self.posterImage.loadUrl(path: self.movieDetailViewModel?.movieDetail?.posterPath ?? "")
                self.titleLabel.text = self.movieDetailViewModel?.movieDetail?.title
                self.releaseYearView.titleLabel.text = self.movieDetailViewModel?.movieDetail?.releaseDate
                self.runtimeView.titleLabel.text = String(self.movieDetailViewModel?.movieDetail?.runtime ?? 0) + ConstantStrings.minutes.localize
                self.setAboutMovieWhenViewDidload()
                self.dismissLoading()
            }
        }
        movieDetailViewModel?.getReviewsForMovie(id: movieDetailViewModel?.movieId ?? 0)
        movieDetailViewModel?.getMovieCast(id: movieDetailViewModel?.movieId ?? 0)
    }
    
    // MARK - This func for showing about movie when viewDidload work
    
    private func setAboutMovieWhenViewDidload(){
        
        aboutMovieButton.addBottomLine()
        
        let aboutMovieView = AboutMovieView(movieOverview: movieDetailViewModel?.movieDetail?.overview ?? "")
        containerView.addSubview(aboutMovieView)
        aboutMovieView.frame = containerView.bounds
    }
    
    private func configureMovieDetailViewController(){
        
        view.backgroundColor = Colors.backGround
        title = ConstantStrings.detail.localize
        let rightBarButtonItem = UIBarButtonItem(image: SFSymbols.unselectedMark, style: .plain, target: self, action: #selector(didMarkButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func didMarkButtonTapped(){
    
        isMarkButtonTapped.toggle()
        
        if isMarkButtonTapped {
            movieDetailViewModel?.addMovieToDatabase(movie: movieDetailViewModel?.movieDetail ?? MovieDetailModel())
            movieDetailViewModel?.errorCallBackWhenAddingDatabase = { [weak self] error in
                guard let self else { return }
                self.presentAlertOnMainThread(with: error)
            }
        }else{
            movieDetailViewModel?.removeMovieFromWatchlist(movieId: movieDetailViewModel?.movieId ?? 0)
            movieDetailViewModel?.errorCallBackForRemoveFromDatabase = { [weak self] error in
                guard let self else { return }
                self.presentAlertOnMainThread(with: error)
            }
        }
    }
    
    private func addSubviews(){
        
        view.addSubviews(backPosterImage, posterImage, titleLabel, runtimeAndCalendarStack, voteAverageView, aboutReviewsCastStack,containerView)
    }
    
    private func configureUIComponents(){
        
        movieDetailViewModel?.checkMovieInDatabase(movieId: movieDetailViewModel?.movieId ?? 0)
        movieDetailViewModel?.successCallBackForCheckMovie = {
            self.isMarkButtonTapped = true
        }
        
        backPosterImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        backPosterImage.layer.cornerRadius = 16
        backPosterImage.clipsToBounds = true
        
        posterImage.layer.cornerRadius = 16
        posterImage.clipsToBounds = true
        
        titleLabel.numberOfLines = 2
        
        aboutMovieButton.addTarget(self, action: #selector(aboutMovieButtonTapped), for: .touchUpInside)
        reviewsButton.addTarget(self, action: #selector(reviewsButtonTapped), for: .touchUpInside)
        castButton.addTarget(self, action: #selector(castButtonTapped), for: .touchUpInside)
    }
    
    @objc func aboutMovieButtonTapped(){
    
        addBottomLineToButtons(aboutMovieButton)
        let aboutMovieView = AboutMovieView(movieOverview: movieDetailViewModel?.movieDetail?.overview ?? "")
        configureContainerView(aboutMovieView)
    }
    
    @objc func reviewsButtonTapped(){
        
        addBottomLineToButtons(reviewsButton)
        let reviewView = ReviewsView(reviews: movieDetailViewModel?.movieReviews ?? [])
        configureContainerView(reviewView)
    }
    
    @objc func castButtonTapped(){
        
        addBottomLineToButtons(castButton)
        let movieCastView = MovieCastView(movieCast: movieDetailViewModel?.movieCast ?? [])
        configureContainerView(movieCastView)
    }
    
    private func addBottomLineToButtons(_ button: MCustomButton){
        
        aboutReviewsCastStack.arrangedSubviews.forEach { view in
            if let button = view as? MCustomButton {
                button.bottomLine.removeFromSuperview()
            }
        }
        button.addBottomLine()
    }
    
    private func configureContainerView(_ view: UIView){
        
        containerView.subviews.forEach { $0.removeFromSuperview() }
        containerView.addSubview(view)
        view.frame = containerView.bounds
    }
    
    private func configureStackViews(){
        
        runtimeAndCalendarStack.axis = .horizontal
        runtimeAndCalendarStack.distribution = .fillEqually
        
        runtimeAndCalendarStack.addArrangedSubViews(releaseYearView,separatorView,runtimeView)
        
        aboutReviewsCastStack.axis = .horizontal
        aboutReviewsCastStack.distribution = .fillEqually
        
        aboutReviewsCastStack.addArrangedSubViews(aboutMovieButton, reviewsButton, castButton)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            backPosterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backPosterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backPosterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backPosterImage.heightAnchor.constraint(equalToConstant: 212),
            
            voteAverageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            voteAverageView.bottomAnchor.constraint(equalTo: backPosterImage.bottomAnchor, constant: -8),
            voteAverageView.heightAnchor.constraint(equalToConstant: 36),
            voteAverageView.widthAnchor.constraint(equalToConstant: 60),
            
            posterImage.topAnchor.constraint(equalTo: backPosterImage.topAnchor, constant: 152),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            posterImage.widthAnchor.constraint(equalToConstant: 96),
            
            titleLabel.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: backPosterImage.bottomAnchor, constant: 12),
            
            runtimeAndCalendarStack.centerXAnchor.constraint(equalTo: backPosterImage.centerXAnchor),
            runtimeAndCalendarStack.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 16),
            runtimeAndCalendarStack.heightAnchor.constraint(equalToConstant: 32),
            runtimeAndCalendarStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            aboutReviewsCastStack.centerXAnchor.constraint(equalTo: backPosterImage.centerXAnchor),
            aboutReviewsCastStack.topAnchor.constraint(equalTo: runtimeAndCalendarStack.bottomAnchor, constant: 24),
            aboutReviewsCastStack.heightAnchor.constraint(equalToConstant: 44),
            aboutReviewsCastStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            containerView.topAnchor.constraint(equalTo: aboutReviewsCastStack.bottomAnchor, constant: 24),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
