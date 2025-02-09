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
    var successCallBack: (()->Void)?
    
    func getWatchListMovies(){
        getWatchListData()
        getGenreNames()
    }
    
    private func getWatchListData(){
        
        PersistanceManager.shared.retrieveFavoriteMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.watchListMovies = data
                self.successCallBack?()
            case .failure(let error):
                print(error)
            }
        }
    }
    func removeFromFavorite(movie: MovieDetailModel) {
        
        PersistanceManager.shared.updateWith(movie: movie, operationType: .remove) { [weak self] error in
            guard let self  = self else { return }
            guard let error = error else {
                print("success")
                return
            }
            print("error")
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
