
import Foundation
import RealmSwift

struct Movies : Codable {
    var backdropPath : String?
    var firstAirDate : String?
    var genreIds : [Int]?
    var originalLanguage : String?
    var posterPath : String?
    var title : String?
    var originCountry : [String]?
    var name : String?
    var voteCount : Int?
    var voteAverage : Double?
    var overview : String?
    var id : Int?
    var popularity : Double?
    var mediaType : String?
    
    enum CodingKeys: String, CodingKey {
        
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case title = "original_name"
        case originCountry = "origin_country"
        case name = "name"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case overview = "overview"
        case id = "id"
        case popularity = "popularity"
        case mediaType = "media_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
    }
    
    init(from movieRealm: WatchLaterMovieRealm) {
        self.title = movieRealm.movieTitle
        self.popularity = movieRealm.popularity
        self.posterPath = movieRealm.posterPath
    }
}
