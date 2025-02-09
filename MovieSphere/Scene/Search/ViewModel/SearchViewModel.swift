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

    func getSearchPageDefaultData(category: Category){
        getGenreList()
        getSearchPageDefaultMovies(category: category)
    }
    
    private func getSearchPageDefaultMovies(category: Category){
        SearchManager.shared.getSearchPageDefaultData(category: category, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                movieModel = data
                searhPageMovies.append(contentsOf: data.results ?? [])
                genreNames = []
                findGenreNameWithIdForSingleMovie()
                successCallBackForSearchPageDefaultMovies?()
            case .failure(let error):
                print(error)
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
                print(error)
            }
        }
    }
    
    func getSearchedMovie(queryParam: String){
        SearchManager.shared.getSearchedMovie(queryParam: queryParam){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                searhPageMovies = data.results ?? []
                genreNames = []
                findGenreNameWithIdForSingleMovie()
                successCallBackForSearchedMovie?()
            case .failure(let error):
                print(error)
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
