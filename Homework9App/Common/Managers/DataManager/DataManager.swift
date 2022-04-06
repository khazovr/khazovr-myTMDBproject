//
//  DataManager.swift
//  Homework9App
//
//  Created by 1 on 15.03.2022.
//

import Foundation
import RealmSwift

struct DataManager {
    
    static let shared = DataManager()
    
    let realm = try? Realm()
    
    private init() { }
    
    func saveMovie(_ movie: Movies, completion: @escaping(() -> ())) {
        
        let watchLaterMovieRealm = WatchLaterMovieRealm()
        
        watchLaterMovieRealm.movieTitle = movie.title ?? ""
        watchLaterMovieRealm.popularity = movie.popularity ?? 0.0
        watchLaterMovieRealm.posterPath = movie.posterPath ?? ""
        
        try? realm?.write {
            realm?.add(watchLaterMovieRealm)
        }
        completion()
    }
    
    func getAllMovies(completion: ([Movies]) -> ()) {
        
        var watchLaterMovieRealm = [WatchLaterMovieRealm]()
        guard let movieResults = realm?.objects(WatchLaterMovieRealm.self) else { return }
        for movie in movieResults {
            watchLaterMovieRealm.append(movie)
        }
        completion(convertToMoviesList(moviesRealm: watchLaterMovieRealm))
    }
    
    private func convertToMoviesList(moviesRealm: [WatchLaterMovieRealm]) -> [Movies] {
        
        var movies = [Movies]()
        for movieRealm in moviesRealm {
            let movie = Movies(from: movieRealm)
            movies.append(movie)
        }
        return movies
    }
    
//    Понимаю, что хочу удалить экземпяр в массиве, а мне нужно работать с реалмом.
    
        func deleteMovie(_ movie: Movies, completion: @escaping(() -> ())) {
        
//        let watchLaterMovieRealm = WatchLaterMovieRealm()
//        
//        watchLaterMovieRealm.movieTitle = movie.title ?? ""
//        watchLaterMovieRealm.popularity = movie.popularity ?? 0.0
//        watchLaterMovieRealm.posterPath = movie.posterPath ?? ""
//        
//        try? realm?.write {
//            realm?.delete(watchLaterMovieRealm)
//        }
        completion()
    }
}

