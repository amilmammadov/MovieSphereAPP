//
//  WatchListViewModel.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 09.02.25.
//

import Foundation

class WatchListViewModel {
    
    var watchListMovies = [MovieDetailModel]()
    var genreNames = [[String]]()
    var successCallBack: (([MovieDetailModel])->Void)?
    
    var errorCallBackForWatchListData: ((String)->Void)?
    var errorCallBackForRemoveMovie: ((String)->Void)?
    
    func getWatchListData(){
        
        FirebaseManager.shared.getWatchListMovies { [weak self] result in
            guard let self = self else { return }
            
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
            guard let self = self else { return }
            
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
}
