//
//  FirebaseManager.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 10.02.25.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let collection = Firestore.firestore().collection("favoriteMovies")
    
    func addMovieToDatabase(movie: MovieDetailModel, completion: @escaping ((FirebaseError?)->Void)){
        
        collection.addDocument(data: movie.convertToDictionary()){ error in
            if let _ = error { completion(.unableToAddMovie) }
            completion(nil)
        }
    }
    
    func checKMovieInDatabase(movieId: Int, completion: @escaping ((FirebaseError?)->Void)){
        
        collection.whereField("id", isEqualTo: movieId).getDocuments(completion: {
            snapshot, error in
            
            if let _ = error { completion(.checkError) }
            
            guard let snapshot = snapshot, !snapshot.documents.isEmpty else {
                completion(.isNotFavorited)
                return
            }
            
            for document in snapshot.documents {
                let movieData = document.data()
                if let id = movieData["id"] as? Int {
                    if id == movieId {
                        completion(nil)
                        return
                    }
                }
            }
            completion(.isNotFavorited)
        })
    }
    
    func getWatchListMovies(completion: @escaping ((Result<[MovieDetailModel], FirebaseError>)->Void)){
        
        collection.getDocuments { snapshot, error in
            
            if let _ = error { completion(.failure(.fetchDataError)) }
            
            guard let snapshot = snapshot, !snapshot.documents.isEmpty else {
                completion(.failure(.noData))
                return
            }
            
            var movies = [MovieDetailModel]()
            for document in snapshot.documents {
                let movieData = document.data()
                if let id = movieData["id"] as? Int,
                   let posterPath = movieData["posterPath"] as? String,
                   let title = movieData["title"] as? String,
                   let genreData = movieData["genres"] as? [[String:Any]],
                   let voteAverage = movieData["voteAverage"] as? Double,
                   let releaseDate = movieData["releaseDate"] as? String{
                    
                    let genreNames = genreData.compactMap { genreDict -> GenreNames? in
                        guard let id = genreDict["id"] as? Int,
                              let name = genreDict["name"] as? String else { return nil }
                        return GenreNames(id: id, name: name)
                    }
                    
                    movies.append(
                        MovieDetailModel(id: id,
                                         backdropPath: nil,
                                         originalLanguage: nil,
                                         title: title,
                                         runtime: nil,
                                         voteAverage: voteAverage,
                                         posterPath: posterPath,
                                         overview: nil,
                                         releaseDate: releaseDate,
                                         genres: genreNames))
                }
            }
            completion(.success(movies))
        }
    }
    
    func removeFromDatabase(movieId: Int, completion: @escaping((FirebaseError?)->Void)){
        
        collection.whereField("id", isEqualTo: movieId).getDocuments(completion: { snapshot, error in
            
            if let _ = error { completion(.fetchDataError) }
            
            guard let snaphot = snapshot, !snaphot.documents.isEmpty else {
                completion(.noData)
                return
            }
            
            for document in snaphot.documents {
                document.reference.delete(completion: { error in
                    
                    if let _ = error {
                        completion(.unableToRemove)
                    }else{
                        completion(nil)
                    }
                })
            }
        })
    }
}
