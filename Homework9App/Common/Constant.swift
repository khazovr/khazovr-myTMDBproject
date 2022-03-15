//
//  Constants.swift
//  Homework9App
//
//  Created by 1 on 25.11.2021.
//

import Foundation

struct Constant {
    
    struct network {
        static let defaultPath = "https://api.themoviedb.org/3/"
        static let defaultImagePath = "https://image.tmdb.org/t/p/original/"
        static let apiKey = "api_key=e98bfe9a7d1f9871d54625e27d59ee6d"
    }
    
    struct requestBody {
        static let movies = "trending/tv/week?"
        static let actors = "person/popular?"
    }
    
    
    struct titles {
        static let cellActionTitle = "Watch later"
    }
    
    struct ui {
        static let imageUrl = "https://image.tmdb.org/t/p/w500/"
    }
    
    struct savedMessage {
        static let saved = "Saved!"
        static let done = "OK"
    }
}
