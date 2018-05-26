//
//  MovieSearchTableViewCell.swift
//  MovieSearch
//
//  Created by Caston  Boyd on 5/25/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieTextView: UITextView!
    @IBOutlet weak var movieReatingLabel: UILabel!
    
    var movies: Movie? {
        didSet {
            updateViews()
            
        }
    }
    
    
    var thumbNail: UIImage? {
        didSet {
            updateViews()
        }
    }
    func updateViews() {
        guard let movie = movies else { return }
        
        if thumbNail != nil{
            movieImage.image = thumbNail
        }
            
        movieTitle.text = "Title: \(String(describing: movie.movieTitle))"
        movieReatingLabel.text = "Rating: \(String(describing: movie.movieRating))"
        movieTextView.text = "Summary: \(String(describing: movie.movieSummary))"
        
        
    }
    
    
}


