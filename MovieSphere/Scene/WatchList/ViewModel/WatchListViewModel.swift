//
//  WatchListViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.02.25.
//

import Foundation

protocol WatchListViewModelProtocol {
    
    var watchListMovies: [MovieDetailModel] { get set }
    var genreNames: [[String]] { get set }
    var successCallBack: (([MovieDetailModel])->Void)? { get set }
    
    var errorCallBackForWatchListData: ((String)->Void)? { get set }
    var errorCallBackForRemoveMovie: ((String)->Void)? { get set }
    
    func getWatchListData()
    func removeMovieFromWatchlist(movieId: Int)
    func goToMovieDetailPage(movieId: Int)
}

final class WatchListViewModel: WatchListViewModelProtocol {
    
    var watchListMovies = [MovieDetailModel]()
    var genreNames = [[String]]()
    var successCallBack: (([MovieDetailModel])->Void)?
    
    var errorCallBackForWatchListData: ((String)->Void)?
    var errorCallBackForRemoveMovie: ((String)->Void)?
    
    var watchListCoordinator: WatchListCoordinator?
    
    func getWatchListData(){
        
        FirebaseManager.shared.getWatchListMovies { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.watchListMovies = data
                self.getGenreNames()
                self.successCallBack?(self.watchListMovies)
            case .failure(let error):
                self.errorCallBackForWatchListData?(error.rawValue)
            }
        }
    }
    
    func removeMovieFromWatchlist(movieId: Int){
        
        FirebaseManager.shared.removeFromDatabase(movieId: movieId) { [weak self] error in
            guard let self else { return }
            
            if let error = error {
                self.errorCallBackForRemoveMovie?(error.rawValue)
            }
        }
    }
    
   private func getGenreNames(){
        
        for movieDetail in watchListMovies {
            var genresForSingleMovie = [String]()
            for genre in movieDetail.genres ?? [] {
                genresForSingleMovie.append(genre.name ?? "")
            }
            genreNames.append(genresForSingleMovie)
        }
    }
    
    func goToMovieDetailPage(movieId: Int) {
        watchListCoordinator?.goToMovieDetailPage(movieId: movieId)
    }
}
