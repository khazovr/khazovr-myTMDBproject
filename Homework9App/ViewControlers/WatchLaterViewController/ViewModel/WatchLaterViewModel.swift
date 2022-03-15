//
//  WatchLaterViewModel.swift
//  Homework9App
//
//  Created by 1 on 15.03.2022.
//

import Foundation

class WatchLaterViewModel {
    
    var movies = [Movies]()
    
    func getAllMovies(completion: @escaping(() -> ())) {
        DataManager.shared.getAllMovies(completion: { movies in
            self.movies = movies
        })
    }
}
