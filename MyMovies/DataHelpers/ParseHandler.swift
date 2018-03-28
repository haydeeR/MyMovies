//
//  ParseHandler.swift
//  MyMovies
//
//  Created by Caludia Carrillo on 3/25/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

struct ParseHandler {
  static func parseMovie(with data: [String: Any]) -> Movie? {
    guard let movie = Mapper<Movie>().map(JSON: data) else {
      return nil
    }
    return movie
  }
  
  static func parseMovies(with data: [String: Any]) -> [Movie] {
    var movies = [Movie]()
    guard let results = data["results"] as? [[String: Any]] else {
      return movies
    }
    movies = Mapper<Movie>().mapArray(JSONArray: results)
    return movies
  }
  
  static func parseRating(with data: [String: Any]) -> Rating? {
    guard let rating = Mapper<Rating>().map(JSON: data) else {
      return nil
    }
    return rating
  }
  
  static func parseMovieLists(with data: [[String: Any]]) -> [MovieList] {
    var lists = [MovieList]()
    lists = Mapper<MovieList>().mapArray(JSONArray: data)
    return lists
  }
  
  static func parseMovieSave(with data: [String: Any]) -> MovieSave? {
    guard let movie = Mapper<MovieSave>().map(JSON: data) else {
      return nil
    }
    return movie
  }
  
  static func parseDictionaryKeysToArray(with data: [String: Any]) -> [String] {
    return Array(data.keys)
  }
}
