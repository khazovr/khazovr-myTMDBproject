//
//  NetworkManager.swift
//  Homework9App
//
//  Created by 1 on 25.11.2021.
//

import Foundation
import Alamofire


struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func requestTrendingMovies(completion: @escaping(([Movies]) -> ())) {
        
        let url = Constant.network.defaultPath + Constant.requestBody.movies + Constant.network.apiKey

        AF.request(url).responseJSON { responce in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularMovie.self, from: responce.data!) {

                let movies = data.results ?? []
                completion(movies)
            }
        }
    }
    
    func requestTrendingActors(completion: @escaping(([Actors]) -> ())) {
        
        let url = Constant.network.defaultPath + Constant.requestBody.actors + Constant.network.apiKey

        AF.request(url).responseJSON { responce in

            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularActors.self, from: responce.data!) {

                let actors = data.results ?? []
                completion(actors)
            }
        }
    }
}
