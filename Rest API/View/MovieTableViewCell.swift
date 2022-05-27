//
//  MovieTableViewCell.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 26/05/22.


import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieOverview: UILabel! 
    
    private var urlString: String = ""
    
    // Setup movies values
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.name, durationTime: String(movie.runtime ??  1 ), overview: movie.summary, poster: movie.image?.original)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, durationTime: String?,  overview: String?, poster: String?) {
        
        self.movieTitle.text = title
        self.movieOverview.text = overview
        
        guard let posterString = poster else {return}
        urlString = "http://api.tvmaze.com/shows/1/episodes" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
             
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
}