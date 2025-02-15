//
//  File.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

class SearchViewModel {
    
    var searhPageMovies = Array<Movie>()
    var genreList = Array<Genre>()
    var genreNames = [[String]]()
    var page: Int = 1
    var movieModel: MovieModel?
    
    var successCallBackForSearchPageDefaultMovies: (()->Void)?
    var successCallBackForSearchedMovie: (()->Void)?
    
    var errorCallBackForSearchPageDefaultMovies: ((String)->Void)?
    var errorCallBackForSearchedMovie: ((String)->Void)?

    func getSearchPageDefaultData(category: Category){
        getGenreList()
        getSearchPageDefaultMovies(category: category)
    }
    
    private func getSearchPageDefaultMovies(category: Category){
        SearchManager.shared.getSearchPageDefaultData(category: category, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieModel = data
                self.searhPageMovies.append(contentsOf: data.results ?? [])
                self.genreNames = []
                self.findGenreNameWithIdForSingleMovie()
                self.successCallBackForSearchPageDefaultMovies?()
            case .failure(let error):
                self.errorCallBackForSearchPageDefaultMovies?(error.rawValue)
            }
        }
    }
    
    func getGenreList(){
        SearchManager.shared.getGenreList { [weak self ] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                genreList = data.genres ?? []
            case .failure(let error):
                break
            }
        }
    }
    
    func getSearchedMovie(queryParam: String){
        SearchManager.shared.getSearchedMovie(queryParam: queryParam){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.searhPageMovies = data.results ?? []
                self.genreNames = []
                self.findGenreNameWithIdForSingleMovie()
                self.successCallBackForSearchedMovie?()
            case .failure(let error):
                self.errorCallBackForSearchedMovie?(error.rawValue)
            }
        }
    }
    
    private func findGenreNameWithIdForSingleMovie(){
        for movie in searhPageMovies {
            var genreListForSingleMovie = [String]()
            for genreId in movie.genreIds! {
                for genre in genreList {
                    if genreId == genre.id {
                        genreListForSingleMovie.append(genre.name ?? "")
                    }
                }
            }
            genreNames.append(genreListForSingleMovie)
        }
    }
    
    func pagination() {
       if movieModel?.page ?? 0 <= movieModel?.totalPages ?? 0 {
           page += 1
           getSearchPageDefaultData(category: .popular)
       }
    }
}
