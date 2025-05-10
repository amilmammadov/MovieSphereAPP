//
//  File.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 01.02.25.
//

import Foundation

protocol SearchViewModelProtocol {
 
    var searhPageMovies: [Movie] { get set }
    var genreList: [Genre] { get set }
    var genreNames: [[String]] { get set }
    var page: Int { get set }
    var movieModel: MovieModel? { get set }
    
    var successCallBackForSearchPageDefaultMovies: (()->Void)? { get set }
    var successCallBackForSearchedMovie: (()->Void)? { get set }
    
    var errorCallBackForSearchPageDefaultMovies: ((String)->Void)? { get set }
    var errorCallBackForSearchedMovie: ((String)->Void)? { get set }
    
    func getSearchPageDefaultData(category: Category)
    func getGenreList()
    func getSearchedMovie(queryParam: String)
    func pagination()
    func goToMovieDetailPage(movieId: Int)
}

final class SearchViewModel: SearchViewModelProtocol {
    
    var searhPageMovies: [Movie] = []
    var genreList: [Genre] = []
    var genreNames: [[String]] = []
    var page: Int = 1
    var movieModel: MovieModel?
    
    var successCallBackForSearchPageDefaultMovies: (()->Void)?
    var successCallBackForSearchedMovie: (()->Void)?
    
    var errorCallBackForSearchPageDefaultMovies: ((String)->Void)?
    var errorCallBackForSearchedMovie: ((String)->Void)?
    
    var searchCoordinator: SearchCoordinator?

    func getSearchPageDefaultData(category: Category){
        getGenreList()
        getSearchPageDefaultMovies(category: category)
    }
    
    private func getSearchPageDefaultMovies(category: Category){
        SearchManager.shared.getSearchPageDefaultData(category: category, page: page) { [weak self] result in
            guard let self else { return }
            
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
            guard let self else { return }
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
            guard let self else { return }
            
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
    
    func goToMovieDetailPage(movieId: Int) {
        searchCoordinator?.goToMovieDetailPage(movieId: movieId)
    }
}
