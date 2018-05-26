//
//  Movie.swift
//  MovieSearch
//
//  Created by Caston  Boyd on 5/25/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import Foundation


struct Movies: Codable {
    
    let results: [Movie]
}

struct Movie: Codable {
    
    let movieTitle: String
    let movieSummary: String
    let movieRating: Float
    let image: String?
    
    private enum CodingKeys: String, CodingKey{
      case  movieTitle =  "title"
      case  movieSummary = "overview"
      case  movieRating = "vote_average"
      case  image = "poster_path"
    }
}
