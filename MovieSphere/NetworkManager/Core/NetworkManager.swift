//
//  NetworkManager.swift
//  MovieSphere
//
//  Created by Amil Mammadov on 29.01.25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(model: T.Type,
                            url: String,
                            method: HTTPMethods = .GET,
                            parameter: T? = nil,
                            headers: [String:String]? = nil,
                            completion: @escaping ((Result<T,NetworkError>)->Void)){
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameter = parameter, method != .GET {
            do {
                request.httpBody = try JSONEncoder().encode(parameter)
            }catch{
                completion(.failure(.encodingError))
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error { completion(.failure(.unableToComplete)) }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidData))
                return
            }
            guard let data = data else {
                completion(.failure(.noContent))
                return
            }
            
            do{
                let data = try JSONDecoder().decode(T.self, from: data)
                completion(.success(data))
            }catch{
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
