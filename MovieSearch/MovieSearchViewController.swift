//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Caston  Boyd on 5/25/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, UISearchBarDelegate  {

    //MARK: - Outlets
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        movieTableView.dataSource = self
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let theUsersSearch = movieSearchBar.text else { return }

        MovieController.fetchMoviesWith(movieName: theUsersSearch) { (movie) in
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
                self.movieSearchBar.text = ""
            }
            
        }
        
        movieSearchBar.resignFirstResponder()
        
        }
    
    }
    
extension MovieSearchViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.sharedInstance.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// Create the set of cell to be reused
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        
        let movie = MovieController.sharedInstance.movies[indexPath.row]
        cell.movies = movie
        MovieController.fetchImageWith(stringURL: movie) { (newImage) in
            DispatchQueue.main.async {
                cell.movies = movie
                if let currentPath = self.movieTableView.indexPath(for: cell), currentPath == indexPath{
                    if cell.movieImage.image == nil {
                        cell.movieImage.image = UIImage(named: "No")
                    } else {
                        cell.movieImage.image = newImage
                        cell.thumbNail = newImage
                        
                    }
                    
                }
            }
        }
        return cell
    }
    
    
}
