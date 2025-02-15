//
//  SearchViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

class SearchViewController: UIViewController {

    let searchField = MCustomSearchBar()
    var searchCollection:UICollectionView!
    let emptySearchView = MEmptySpaceView(image: SFSymbols.emptySearchView ?? UIImage(), title: "empty_space_view_title".localize, subTitle: "empty_space_view_subtitle".localize)
    
    var searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureSearchCollection()
        addSubviews()
        setConstraints()
        configureData()
        confiureSearchField()
    }
    private func configureData(){
        
        showLoading()
        searchViewModel.getSearchPageDefaultData(category: .popular)
        searchViewModel.successCallBackForSearchPageDefaultMovies = {
            DispatchQueue.main.async {
                self.searchCollection.reloadData()
                self.dismissLoading()
            }
        }
        
        searchViewModel.errorCallBackForSearchPageDefaultMovies = { [weak self] error in
            guard let self = self else { return }
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
            searchViewModel.getSearchPageDefaultData(category: .popular)
        }else {
            
            searchViewModel.getSearchedMovie(queryParam: query)
            searchViewModel.successCallBackForSearchedMovie = {
                if self.searchViewModel.searhPageMovies.isEmpty{
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
            
            searchViewModel.errorCallBackForSearchedMovie = { [weak self] error in
                guard let self = self else { return }
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
        
        let alertController = UIAlertController(title: nil, message: "search_information".localize, preferredStyle: .actionSheet)
        alertController.view.tintColor = .red
        let alertAction = UIAlertAction(title: "close".localize, style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    private func addSubviews(){
        view.addSubviews(searchField, searchCollection)
    }
    
    private func configureSearchCollection(){
        searchCollection = UICollectionView(frame: .zero, collectionViewLayout: createSearchCollectionLayout())
        searchCollection.backgroundColor = Colors.backGround
        searchCollection.configure(self, MLeftImageRightDetailCell.self, MLeftImageRightDetailCell.reuseId)
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
        searchViewModel.searhPageMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: MLeftImageRightDetailCell.reuseId, for: indexPath) as! MLeftImageRightDetailCell
        cell.setData(movie: searchViewModel.searhPageMovies[indexPath.row], genreList: searchViewModel.genreNames[indexPath.row])
        cell.genreCollection.reloadData()
        return cell
    }
}
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movieId = searchViewModel.searhPageMovies[indexPath.row].id
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let contenOffset = scrollView.contentOffset.y
        let contentSize = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if contenOffset > contentSize - height {
           
            searchViewModel.pagination()
        }
    }
}
