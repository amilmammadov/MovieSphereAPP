//
//  PersistanceManager.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 08.02.25.
//

import Foundation

enum Keys {
    static let favorite = "Favorite"
}

enum OperationType{
    case add, remove
}


class PersistanceManager {
    static let shared = PersistanceManager()
    
    func updateWith(movie: MovieDetailModel, operationType: OperationType, completion: @escaping((PersistanceError?)->Void)){
        
        retrieveFavoriteMovies { result in
            switch result {
            case .success(let movies):
                var retrievedMovies = movies
                
                switch operationType {
                case .add:
                    guard !retrievedMovies.contains(where: {$0.id == movie.id}) else {
                        completion(.duplicate)
                        return
                    }
                    retrievedMovies.append(movie)
                case .remove:
                    retrievedMovies.removeAll {$0.id == movie.id}
                }
                completion(self.addToFavorites(movies: retrievedMovies))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func addToFavorites(movies: [MovieDetailModel])->PersistanceError?{
        
        do {
            let encodedData = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(encodedData, forKey: Keys.favorite)
            return nil
        }catch {
            return .unableToAddFavorites
        }
    }
    
    func retrieveFavoriteMovies(completion: @escaping((Result<[MovieDetailModel], PersistanceError>)->Void)){
        
        guard let retrievedData = UserDefaults.standard.object(forKey: Keys.favorite) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode([MovieDetailModel].self, from: retrievedData)
            completion(.success(decodedData))
        }catch {
            completion(.failure(.unableToRetrieve))
        }
    }
}
