//
//  MovieDetailViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let backPosterImage = UIImageView()
    let posterImage = UIImageView()
    let titleLabel = MTitleLabel(text: nil, font: MFont.poppinsSemiBold, size: 18, textAlignment: .justified)
    let voteAverageView = MLeftIconRightLabelView(icon: SFSymbols.star ?? UIImage(), title: nil, color: Colors.starColor ?? UIColor(), font: 16)
    
    let releaseYearView = MLeftIconRightLabelView(icon: SFSymbols.calendar ?? UIImage(), title: nil, color: Colors.seacrhIcon ?? UIColor(), font: 12)
    let runtimeView = MLeftIconRightLabelView(icon: SFSymbols.clock ?? UIImage(), title: nil, color: Colors.seacrhIcon ?? UIColor(), font: 12)
    let separatorView = MSeperatorView()
    let runtimeAndCalendarStack = UIStackView()
    
    let aboutMovieButton = MCustomButton(title: ConstantStrings.aboutMovie, font: MFont.poppinsMedium, size: 14)
    let reviewsButton = MCustomButton(title: ConstantStrings.reviews, font: MFont.poppinsMedium, size: 14)
    let castButton = MCustomButton(title: ConstantStrings.cast, font: MFont.poppinsMedium, size: 14)
    let aboutReviewsCastStack = UIStackView()
    
    let containerView = UIView()
    
    var movieId: Int?
    let movieDetailViewModel = MovieDetailViewModel()
    var tappedButton = ConstantStrings.aboutMovie
    
    var isMarkButtonTapped = false {
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
        movieDetailViewModel.getMovieDetail(id: movieId ?? 0)
        movieDetailViewModel.successCallBackForMovieDetail = {
            DispatchQueue.main.async {
                self.backPosterImage.loadUrl(path: self.movieDetailViewModel.movieDetail?.backdropPath ?? "")
                self.voteAverageView.titleLabel.text = String(self.movieDetailViewModel.movieDetail?.voteAverage ?? 0)
                self.posterImage.loadUrl(path: self.movieDetailViewModel.movieDetail?.posterPath ?? "")
                self.titleLabel.text = self.movieDetailViewModel.movieDetail?.title
                self.releaseYearView.titleLabel.text = self.movieDetailViewModel.movieDetail?.releaseDate
                self.runtimeView.titleLabel.text = String(self.movieDetailViewModel.movieDetail?.runtime ?? 0) + " Minutes"
                self.setAboutMovieWhenViewDidload()
                self.dismissLoading()
            }
        }
        movieDetailViewModel.getReviewsForMovie(id: movieId ?? 0)
        movieDetailViewModel.getMovieCast(id: movieId ?? 0)
    }
    
    // MARK - This func for showing about movie when viewDidload work
    
    private func setAboutMovieWhenViewDidload(){
        
        aboutMovieButton.addBottomLine()
        
        let aboutMovieView = AboutMovieView(movieOverview: movieDetailViewModel.movieDetail?.overview ?? "")
        containerView.addSubview(aboutMovieView)
        aboutMovieView.frame = containerView.bounds
    }
    
    private func configureMovieDetailViewController(){
        
        view.backgroundColor = Colors.backGround
        title = "Detail"
        let rightBarButtonItem = UIBarButtonItem(image: SFSymbols.unselectedMark, style: .plain, target: self, action: #selector(didMarkButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func didMarkButtonTapped(){
        
        isMarkButtonTapped.toggle()
        
        PersistanceManager.shared.updateWith(movie: movieDetailViewModel.movieDetail ?? MovieDetailModel(), operationType: .add) { [weak self] error in
            
            guard let self = self else { return }
            guard let error = error else {
                print("success")
                return
            }
            print(error)
        }
    }
    
    private func addSubviews(){
        
        view.addSubviews(backPosterImage, posterImage, titleLabel, runtimeAndCalendarStack, voteAverageView, aboutReviewsCastStack,containerView)
    }
    
    private func configureUIComponents(){
        
        PersistanceManager.shared.retrieveFavoriteMovies { result in
            switch result {
            case .success(let data):
                
                data.forEach { movieDetail in
                    if movieDetail.id == self.movieId {
                        DispatchQueue.main.async {
                            self.navigationItem.rightBarButtonItem?.image = SFSymbols.selectedMark
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
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
        let aboutMovieView = AboutMovieView(movieOverview: movieDetailViewModel.movieDetail?.overview ?? "")
        configureContainerView(aboutMovieView)
    }
    
    @objc func reviewsButtonTapped(){
        
        addBottomLineToButtons(reviewsButton)
        let reviewView = ReviewsView(reviews: movieDetailViewModel.movieReviews ?? [])
        configureContainerView(reviewView)
    }
    
    @objc func castButtonTapped(){
        
        addBottomLineToButtons(castButton)
        let movieCastView = MovieCastView(movieCast: movieDetailViewModel.movieCast ?? [])
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
        
        backPosterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        runtimeAndCalendarStack.translatesAutoresizingMaskIntoConstraints = false
        voteAverageView.translatesAutoresizingMaskIntoConstraints = false
        aboutReviewsCastStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
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
