//
//  WatchLaterViewModel.swift
//  Homework9App
//
//  Created by 1 on 15.03.2022.
//

import Foundation
import RealmSwift

class WatchLaterViewModel {
    
    var movies = [Movies]()
    
    func getAllMovies(completion: @escaping(() -> ())) {
        DataManager.shared.getAllMovies(completion: { movies in
            self.movies = movies
        })
    }
    
    func deletedMovieFromRealm(_ movie: Movies?, completion: @escaping(() -> ())) {

        guard let movie = movie else {
            return
        }
        DataManager.shared.deleteMovie(movie, completion: completion)
    }
}
