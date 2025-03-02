//
//  WatchListViewController.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 27.01.25.
//

import UIKit

final class WatchListViewController: UIViewController {
    
    private let watchListCollection = UITableView()
    private let watchListViewModel = WatchListViewModel()
    private let emptyFavoriteView = MEmptySpaceView(image: SFSymbols.emptyFavoriteView ?? UIImage(), title: ConstantStrings.emptyFavoriteViewTitle.localize, subTitle: ConstantStrings.emptyFavoriteViewSubTitle.localize)
    
    var watchListCoordinator: WatchListCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.backGround
        
        configureWatchListCollection()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureData()
    }
    
    private func configureData(){
        
        showLoading()
        watchListViewModel.getWatchListData()
        watchListViewModel.successCallBack = { watchListMovies in
            DispatchQueue.main.async {
                if watchListMovies.isEmpty {
                    self.watchListCollection.reloadData()
                    self.addEmptyFavoriteView()
                }else{
                    self.emptyFavoriteView.removeFromSuperview()
                    self.watchListCollection.reloadData()
                }
                self.dismissLoading()
            }
        }
        
        watchListViewModel.errorCallBackForWatchListData = { [weak self] error in
            guard let self else { return }
            self.presentAlertOnMainThread(with: error)
        }
    }
    
    private func addEmptyFavoriteView(){
        
        view.addSubview(emptyFavoriteView)
        emptyFavoriteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyFavoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            emptyFavoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyFavoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyFavoriteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureWatchListCollection(){
        
        watchListCollection.frame = view.bounds
        watchListCollection.rowHeight = 140
        watchListCollection.backgroundColor = Colors.backGround
        watchListCollection.configure(self, MLeftImageRightInfoCell.self, MLeftImageRightInfoCell.reuseId)
    }
   
    private func configure(){
        
        view.addSubview(watchListCollection)
        watchListCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            watchListCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            watchListCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchListCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            watchListCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WatchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchListViewModel.watchListMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = watchListCollection.dequeueReusableCell(withIdentifier: MLeftImageRightInfoCell.reuseId, for: indexPath) as! MLeftImageRightInfoCell
        cell.setData(movie: watchListViewModel.watchListMovies[indexPath.row], genreList: watchListViewModel.genreNames[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _,_,_ in
            guard let self else { return }
            
            let movie = self.watchListViewModel.watchListMovies[indexPath.row]
            self.watchListViewModel.watchListMovies.remove(at: indexPath.row)
            self.watchListCollection.deleteRows(at: [indexPath], with: .left)
            
            self.watchListViewModel.removeMovieFromWatchlist(movieId: movie.id ?? 0)
            self.watchListViewModel.errorCallBackForRemoveMovie = { [weak self] error in
                guard let self else { return }
                self.presentAlertOnMainThread(with: error)
            }
            
            self.watchListViewModel.getWatchListData()
            
            guard !self.watchListViewModel.watchListMovies.isEmpty else {
                self.addEmptyFavoriteView()
                return
            }
        }
        
        deleteAction.image = SFSymbols.trash?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = Colors.searchTextFieldBackGround
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeActionConfiguration.performsFirstActionWithFullSwipe = false
        return swipeActionConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        watchListCoordinator?.goToMovieDetailPage(movieId: watchListViewModel.watchListMovies[indexPath.row].id ?? 0)
    }
}


    

