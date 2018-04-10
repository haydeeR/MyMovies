//
//  MovieList.swift
//  MyMovies
//
//  Created by Caludia Carrillo on 3/22/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieList: DBModel, Mappable {
  var id = UUID().uuidString
  var name = "No name"
  var movies = [MovieBrief]()

  init?(map: Map) {
    
  }
  
  init(name: String) {
    self.name = name
  }
  
  mutating func mapping(map: Map) {
    id           <- map["id"]
    name         <- map["name"]
    var movies = [MovieBrief]()
    movies       <- map["movies"]
    self.movies = movies
  }
  
  func toDictionary() -> [String: Any] {
    return [
      "id": id,
      "name": name,
      "movie": movies
    ]
  }
}
