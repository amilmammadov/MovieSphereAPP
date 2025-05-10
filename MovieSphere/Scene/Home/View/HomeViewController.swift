//
//  HomeViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let titleLabel = MTitleLabel(text: ConstantStrings.homePageTitle.localize, font: MFont.poppinsSemiBold, size: 18,textAlignment: .left)
    private let searchField = MCustomSearchBar()
    
    lazy var horizontalMovieCollection: UICollectionView = {
        let horizontalMovieCollection = UICollectionView(frame: .zero, collectionViewLayout: createHorizontalMovieCollectionLayout())
        horizontalMovieCollection.backgroundColor = Colors.backGround
        horizontalMovieCollection.showsHorizontalScrollIndicator = false
        horizontalMovieCollection.configure(self, MSingleImageCell.self, MSingleImageCell.reuseId)
        return horizontalMovieCollection
    }()
    
    lazy var categoryCollection: UICollectionView = {
        let categoryCollection = UICollectionView(frame: .zero, collectionViewLayout: createCategoryCollectionlayout())
        categoryCollection.backgroundColor = Colors.backGround
        categoryCollection.showsHorizontalScrollIndicator = false
        categoryCollection.configure(self, MCategoryCell.self, MCategoryCell.reuseId)
        return categoryCollection
    }()
    
    lazy var movieCollectionForSingleCategory: UICollectionView = {
        let movieCollectionForSingleCategory = UICollectionView(frame: .zero, collectionViewLayout: createMovieCollectionForSingleCategoryLayout())
        movieCollectionForSingleCategory.backgroundColor = Colors.backGround
        movieCollectionForSingleCategory.showsVerticalScrollIndicator = false
        movieCollectionForSingleCategory.configure(self, MSingleImageCell.self, MSingleImageCell.reuseId)
        return movieCollectionForSingleCategory
    }()
    
    private var searchView = SearchView()
    
    var homeViewModel: HomeViewModelProtocol?
    var searchViewModel: SearchViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        configureSelectedCategory()
        configureSearchField()
        addSubViews()
        setConstraints()
        configureData()
    }
    
    private func configureData(){
        
        showLoading()
        homeViewModel?.getHorizontalCollectionMovies(category: .popular)
        homeViewModel?.getSingleCategoryMovies(category: .nowPlaying, isNewCategory: true)
        homeViewModel?.successCallBackForHorizontalCMovies = {
            DispatchQueue.main.async {
                self.horizontalMovieCollection.reloadData()
                self.dismissLoading()
            }
        }
        
        homeViewModel?.errorCallBackForHorizontalCMovies = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
        
        homeViewModel?.successCallBackForSingleCategoryMovies = {
            DispatchQueue.main.async {
                self.movieCollectionForSingleCategory   .reloadData()
                self.dismissLoading()
            }
        }
        
        homeViewModel?.errroCallBackForSingleCategoryMovies = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
    }
    
    private func addSubViews(){
        
        view.addSubviews(titleLabel, searchField, horizontalMovieCollection, categoryCollection, movieCollectionForSingleCategory)
    }
    
    private func configureSearchField(){
        
        searchField.addTarget(self, action: #selector(searchFieldTapped), for: .editingChanged)
    }
    
    @objc func searchFieldTapped(){
        
        searchView.delegate = self
    
        let query = searchField.text ?? ""
        if !query.isEmpty {
            searchViewModel?.getGenreList()
            searchViewModel?.getSearchedMovie(queryParam: query)
            searchViewModel?.successCallBackForSearchedMovie = {
                self.searchView.movies = self.searchViewModel?.searhPageMovies ?? []
                self.searchView.genreList = self.searchViewModel?.genreNames ?? []
                DispatchQueue.main.async {
                    self.searchView.searchCollection.reloadData()
                }
            }
            view.addSubview(searchView)
            searchView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                searchView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 24),
                searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
        }else {
            searchView.removeFromSuperview()
        }
    }
    
    // MARK - This line for adding bottomline to nowplaying category when viewDidload work

    private func configureSelectedCategory(){
        
        DispatchQueue.main.async {
            if let cell = self.categoryCollection.cellForItem(at: IndexPath(item: 0, section: 0)) as? MCategoryCell {
                cell.addBottomLineToCell()
            }
        }
    }
    
    private func createHorizontalMovieCollectionLayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    private func createCategoryCollectionlayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 12
        return layout
    }
    private func createMovieCollectionForSingleCategoryLayout()->UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.minimumLineSpacing = 20
        return layout
    }
    
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case horizontalMovieCollection:
            return homeViewModel?.horizontalCollectionMovies.count ?? 0
        case categoryCollection:
            return homeViewModel?.movieCategories.count ?? 0
        case movieCollectionForSingleCategory:
            return homeViewModel?.singleCategoryCollectionMovies.count ?? 0
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case horizontalMovieCollection:
            
            guard let cell = horizontalMovieCollection.dequeueReusableCell(withReuseIdentifier: MSingleImageCell.reuseId, for: indexPath) as? MSingleImageCell else { return UICollectionViewCell() }
            if let horizontalCollectionMovie = homeViewModel?.horizontalCollectionMovies[indexPath.item] {
                cell.set(movie: horizontalCollectionMovie)
            }
            return cell
            
        case categoryCollection:
            
            guard let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: MCategoryCell.reuseId, for: indexPath) as? MCategoryCell else { return UICollectionViewCell() }
            cell.setTitle(homeViewModel?.movieCategories[indexPath.item].localize ?? "")
            return cell
            
        case movieCollectionForSingleCategory:
            
            guard let cell = movieCollectionForSingleCategory.dequeueReusableCell(withReuseIdentifier: MSingleImageCell.reuseId, for: indexPath) as? MSingleImageCell else { return UICollectionViewCell() }
        
            if let categoryMovie = homeViewModel?.singleCategoryCollectionMovies[indexPath.item] {
                switch homeViewModel?.selectedCategery {
                case .nowPlaying:
                    cell.set(movie: categoryMovie)
                case .upComing:
                    cell.set(movie: categoryMovie)
                case .topRated:
                    cell.set(movie: categoryMovie)
                case .popular:
                    cell.set(movie: categoryMovie)
                default:
                    break
                }
            }

            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case horizontalMovieCollection:
            homeViewModel?.goToMovieDetail(movieId: homeViewModel?.horizontalCollectionMovies[indexPath.item].id ?? 0)
        case categoryCollection:
            
            switch indexPath.item {
            case 0:
                configureSingleCategoryCellWhenTapped(category: .nowPlaying, collectionView: collectionView, indexPath: indexPath)
            case 1:
                configureSingleCategoryCellWhenTapped(category: .upComing, collectionView: collectionView, indexPath: indexPath)
            case 2:
                configureSingleCategoryCellWhenTapped(category: .topRated, collectionView: collectionView, indexPath: indexPath)
            case 3:
                configureSingleCategoryCellWhenTapped(category: .popular, collectionView: collectionView, indexPath: indexPath)
            default:
                break
            }
            
        case movieCollectionForSingleCategory:
            homeViewModel?.goToMovieDetail(movieId: homeViewModel?.singleCategoryCollectionMovies[indexPath.item].id ?? 0)
        default:
            break
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        switch scrollView {
        case horizontalMovieCollection:
            
            let contenOffset = scrollView.contentOffset.x
            let contentSize = scrollView.contentSize.width
            let width = scrollView.frame.size.width
            
            if contenOffset > contentSize - width {
                homeViewModel?.horizontalCollectionPagination()
            }
        case movieCollectionForSingleCategory:
            
            let contenOffset = scrollView.contentOffset.y
            let contentSize = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
            if contenOffset > contentSize - height {
                homeViewModel?.verticalCollectionPagination(category: homeViewModel?.selectedCategery ?? .nowPlaying)
            }
        default:
            break
        }
    }
    
    private func removeBottomLineFromAllCells(_ collectionView: UICollectionView, _ indexPath: IndexPath){
        for cell in collectionView.visibleCells {
            if let categoryCell = cell as? MCategoryCell {
                categoryCell.bottomLine.removeFromSuperview()
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? MCategoryCell {
            cell.addBottomLineToCell()
        }
    }
    private func configureSingleCategoryCellWhenTapped(category: Category, collectionView: UICollectionView, indexPath: IndexPath){
        homeViewModel?.selectedCategery = category
        removeBottomLineFromAllCells(collectionView, indexPath)
        showLoading()
        homeViewModel?.getSingleCategoryMovies(category: category, isNewCategory: true)
        movieCollectionForSingleCategory.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    private func setConstraints(){
        
        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchField.heightAnchor.constraint(equalToConstant: 44),
            
            horizontalMovieCollection.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: padding),
            horizontalMovieCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalMovieCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalMovieCollection.heightAnchor.constraint(equalToConstant: 220),
            
            categoryCollection.topAnchor.constraint(equalTo: horizontalMovieCollection.bottomAnchor, constant: padding),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: 52),
            
            movieCollectionForSingleCategory.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 20),
            movieCollectionForSingleCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieCollectionForSingleCategory.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCollectionForSingleCategory.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case horizontalMovieCollection:
            return CGSize(width: 144, height: 212)
        case categoryCollection:
            return CGSize(width: (homeViewModel?.movieCategories[indexPath.row].count ?? 0) * 12 , height: 48)
        case movieCollectionForSingleCategory:
            return CGSize(width: ( view.frame.size.width - 72 ) / 3, height: 148)
        default:
            return CGSize()
        }
    }
}

extension HomeViewController: SearchViewDelegate {
    
    func didMovieTapped(movieId: Int) {
        homeViewModel?.goToMovieDetail(movieId: movieId)
    }
}



