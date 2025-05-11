//
//  SearchViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

final class SearchViewController: UIViewController {

    private let searchField = MCustomSearchBar()
    
    private lazy var searchCollection:UICollectionView = {
        let searchCollection = UICollectionView(frame: .zero, collectionViewLayout: createSearchCollectionLayout())
        searchCollection.backgroundColor = Colors.backGround
        searchCollection.configure(self, MLeftImageRightDetailCell.self, MLeftImageRightDetailCell.reuseId)
        return searchCollection
    }()
    
    private let emptySearchView = MEmptySpaceView(image: SFSymbols.emptySearchView ?? UIImage(), title: ConstantStrings.emptySpaceViewTitle.localize, subTitle: ConstantStrings.emptySpaceViewSubTitle.localize)
    
    var searchViewModel: SearchViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        addSubviews()
        setConstraints()
        configureData()
        confiureSearchField()
    }
    private func configureData(){
        
        showLoading()
        searchViewModel?.getSearchPageDefaultData(category: .popular)
        searchViewModel?.successCallBackForSearchPageDefaultMovies = {
            DispatchQueue.main.async {
                self.searchCollection.reloadData()
                self.dismissLoading()
            }
        }
        
        searchViewModel?.errorCallBackForSearchPageDefaultMovies = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
    }
    // MARK - Add target to searhfield to search spesifik movie
    
    private func confiureSearchField(){
        
        searchField.addTarget(self, action: #selector(findSearchedMovie), for: .editingChanged)
    }
    
    @objc func findSearchedMovie(){
        
        let query = searchField.text ?? ""
        
        if query.isEmpty {
            searchViewModel?.getSearchPageDefaultData(category: .popular)
        }else {
            
            searchViewModel?.getSearchedMovie(queryParam: query)
            searchViewModel?.successCallBackForSearchedMovie = {
                if self.searchViewModel?.searhPageMovies == [] {
                    DispatchQueue.main.async {
                        self.addEmptySpaceView()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.emptySearchView.removeFromSuperview()
                        self.searchCollection.reloadData()
                    }
                }
            }
            
            searchViewModel?.errorCallBackForSearchedMovie = { [weak self] error in
                guard let self else { return }
                self.presentAlertOnMainThread(with: error)
            }
        }
    }
    
    private func addEmptySpaceView(){
        
        view.addSubview(emptySearchView)
        emptySearchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptySearchView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 24),
            emptySearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptySearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptySearchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationController(){
        let rightBarButtonItem = UIBarButtonItem(image: SFSymbols.informationButton, style: .plain, target: self, action: #selector(informationButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func informationButtonTapped(){
        
        let alertController = UIAlertController(title: nil, message: ConstantStrings.searchInformation.localize, preferredStyle: .actionSheet)
        alertController.view.tintColor = .red
        let alertAction = UIAlertAction(title: ConstantStrings.close.localize, style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    private func addSubviews(){
        view.addSubviews(searchField, searchCollection)
    }
    
    private func createSearchCollectionLayout()->UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width * 0.9, height: 120)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    private func setConstraints(){
        
        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchField.heightAnchor.constraint(equalToConstant: 44),
            
            searchCollection.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: padding),
            searchCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchViewModel?.searhPageMovies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: MLeftImageRightDetailCell.reuseId, for: indexPath) as! MLeftImageRightDetailCell
        
        if let movie = searchViewModel?.searhPageMovies[indexPath.row], let genreList = searchViewModel?.genreNames[indexPath.row] {
            cell.setData(movie: movie, genreList: genreList)
        }
        cell.genreCollection.reloadData()
        return cell
    }
}
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchViewModel?.goToMovieDetailPage(movieId: searchViewModel?.searhPageMovies[indexPath.item].id ?? 0)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let contenOffset = scrollView.contentOffset.y
        let contentSize = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if contenOffset > contentSize - height {
           
            searchViewModel?.pagination()
        }
    }
}
