//
//  MainViewControllerModel.swift
//  Homework9App
//
//  Created by 1 on 25.11.2021.
//

import Foundation

class MainViewModel {
    
    var movies: [Movies] = []
    var actors: [Actors] = []
    
    func loadMovies(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingMovies(completion: { movies in
            self.movies = movies
            completion()
        })
    }
    
    func loadActors(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingActors(completion: { actors in
            self.actors = actors
            completion()
        })
    }
    
    func saveMovieInRealm(_ movie: Movies?, completion: @escaping(() -> ())) {
        
        guard let movie = movie else {
            return
        }
        DataManager.shared.saveMovie(movie, completion: completion)
    }
}
