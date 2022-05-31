//
//  MovieTableViewCell.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 26/05/22.


import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieDetails: UILabel!
    
    private var urlString: String = ""
    
    // Setup movies values
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.name, durationTime: String(movie.runtime ??  1 ), overview: movie.summary, poster: movie.image?.original, seasons: String(movie.season ?? 1), episodes: String(movie.number ?? 1))
    }
    
    
    // Update the UI Views
    private func updateUI(title: String?, durationTime: String?,  overview: String?, poster: String?,  seasons:  String?, episodes: String?) {
        self.movieTitle.text = title
        self.movieOverview.text = overview
        let movieDetailsString = "S \(seasons ?? "") E \(episodes ?? "") | \(durationTime ?? "") mins"
        movieDetails.text = movieDetailsString
        
        guard let posterImageURL = URL(string: poster ?? "") else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        moviePoster.downloaded(from: posterImageURL) { [weak self] image in
            guard let self = self else { return }
            self.moviePoster.image = image
        }
        
       
    }
}
