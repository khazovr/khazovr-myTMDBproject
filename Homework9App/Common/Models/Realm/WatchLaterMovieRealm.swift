//
//  WatchLaterMovieModel.swift
//  Homework9App
//
//  Created by 1 on 09.11.2021.
//

import Foundation
import RealmSwift

class WatchLaterMovieRealm: Object {
    
    @objc dynamic var movieTitle = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var posterPath = ""
    
}
