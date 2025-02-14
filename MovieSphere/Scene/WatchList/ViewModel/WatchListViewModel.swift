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
    
    func getWatchListData(){
        
        FirebaseManager.shared.getWatchListMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.watchListMovies = data
                getGenreNames()
                self.successCallBack?(self.watchListMovies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeMovieFromWatchlist(movieId: Int){
        
        FirebaseManager.shared.removeFromDatabase(movieId: movieId) { error in
            if let error = error {
                print(error)
            }
            
            print("Movie removed")
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
