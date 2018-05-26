//
//  MovieController.swift
//  MovieSearch
//
//  Created by Caston  Boyd on 5/25/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    //
    static let sharedInstance = MovieController()
    
    //MARK: - Base Url
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/search/movie")!
    static let imageUrl = URL(string: "http://image.tmdb.org/t/p/w300")
    //MARK: - API Key
    static let apiKey = "6a6fa20c1eb5b4e843966dbc33379ab5"
    
    //MARK: - Properties
    var movies = [Movie]()
    
    //Step 1: URL
    static func fetchMoviesWith(movieName: String, completion: @escaping ([Movie]?) -> Void) {
        let url = MovieController.baseUrl
        let urlParameters = ["query": "\(movieName)", "api_key": apiKey]
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = urlParameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        components?.queryItems = queryItems
        
        
        
        guard let requestUrl = components?.url else { completion(nil) ; return }
        print("\(requestUrl.absoluteString)")
        
        
        //Step 2: Request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        
        //Step 3: URLSessionDatatask + RESUME
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error downloading with DataTask\(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            do {
                
                let moviesDictionary = try jsonDecoder.decode(Movies.self, from: data)
                let movies = moviesDictionary.results.compactMap{$0}
                self.sharedInstance.movies = movies
                completion(movies)
                // /l1yltvzILaZcx2jYvc5sEMkM7Eh.jpg
                
            } catch let error {
                print("Error Loading \(error.localizedDescription) \(error)")
                
            }
            
            } .resume()
        
        
    }
    
    static func fetchImageWith(stringURL: Movie, completion: @escaping ((UIImage?)-> Void)){
        guard let imageBase = self.imageUrl else { return }
        
        let request = imageBase.appendingPathComponent(stringURL.image ?? "")
       

//
        URLSession.shared.dataTask(with: request) { (data, _ , error) in
            if let error = error {
                print("Error with DataTask dowloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return }
            guard let image = UIImage(data: data) else { completion(nil) ; return }
            completion(image)
            print(request)
            
            }.resume()
    }
    
}///end of class






