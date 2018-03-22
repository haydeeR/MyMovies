//
//  MovieDetailViewController.swift
//  MyMovies
//
//  Created by Caludia Carrillo on 3/21/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import UIKit
import AlamofireImage
import Cosmos

class MovieDetailViewController: UIViewController {
  @IBOutlet private weak var movieImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var taglineLabel: UILabel!
  @IBOutlet private weak var yearLabel: UILabel!
  @IBOutlet private weak var runtimeLabel: UILabel!
  @IBOutlet private weak var genresLabel: UILabel!
  @IBOutlet private weak var overviewLabel: UILabel!
  @IBOutlet private weak var cosmosView: CosmosView!
  private var movie: Movie!
  var genres = [Genre]()
  var movieId: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cosmosViewActions()
    guard let movieId = movieId else {
      return
    }
    
    MyMoviesService.getMovie(with: movieId).then(execute: { movie -> Void in
      self.movie = movie
      self.movie.genres = self.genres
      self.updateUI()
    }).catch(execute: { error in
      print(error)
    })
  }
  
  private func cosmosViewActions() {
    cosmosView.didFinishTouchingCosmos = { rating in
      print(rating)
    }
    
    cosmosView.didTouchCosmos = { rating in
      print(rating)
    }
  }
  
  private func updateUI() {
    titleLabel.text = movie.title
    overviewLabel.text = movie.sinopsis + movie.sinopsis + movie.sinopsis
    
    if let url = URL(string: APIManager.baseImageURLdetail+movie.backPath) {
      movieImageView.af_setImage(withURL: url)
    }
    
    genresLabel.text = movie.genresString.uppercased()
    taglineLabel.text = !movie.tagline.isEmpty ? "\"\(movie.tagline)\"" : ""
    runtimeLabel.text = movie.runtime > 0 ? "\(movie.runtime) min." : ""
  }
  
  private func updateRating() {
    cosmosView.rating = 0
  }
}
