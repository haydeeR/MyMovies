//
//  MyMoviesRepository.swift
//  MyMovies
//
//  Created by Caludia Carrillo on 3/20/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Alamofire
import PromiseKit
import FirebaseDatabase

struct MyMoviesRepository {
  //Firebase Database
  static var databaseRef = Database.database().reference()
  static let movielistsRef = Database.database().reference(withPath: FirebasePath.lists.rawValue)
  static let ratingsRef = Database.database().reference(withPath: FirebasePath.ratings.rawValue)
  
  static func getRequest(for type: MovieType, page: Int) -> URLRequestConvertible {
    switch type {
    case .featured:
      return MyMoviesRouter.getFeatured(page: page)
    case .upcoming:
      return MyMoviesRouter.getUpcoming(page: page)
    }
  }
  
  static func getMovies(for type: MovieType, page: Int = 1) -> Promise <[String: Any]> {
    return Promise { fulfill, reject in
      Alamofire.request(getRequest(for: type, page: page))
      .validate()
        .responseJSON(completionHandler: { response in
          if let json = response.result.value as? [String: Any] {
            fulfill(json)
          } else if let error = response.error {
            reject(error)
          }
        })
    }
  }
  
  static func getMovie(with id: Int) -> Promise <[String: Any]> {
    return Promise { fulfill, reject in
      Alamofire.request(MyMoviesRouter.getMovie(id: id))
        .validate()
        .responseJSON(completionHandler: { response in
          if let json = response.result.value as? [String: Any] {
            fulfill(json)
          } else if let error = response.error {
            reject(error)
          }
        })
    }
  }
  
  static func getUserRating(for movieId: Int)  -> Promise <[String: Any]>{
    return Promise { fullfill, reject in
      
      
    }
  }

}
