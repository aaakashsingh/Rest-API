//
//  ApiService.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 26/05/22.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let popularMoviesURL = "http://api.tvmaze.com/shows/1/episodes"
        
        guard let url = URL(string: popularMoviesURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error 
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Movie].self, from: data)
                print(jsonData)
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
    }
}
