
import Foundation
struct KnownFor : Codable {
	let backdropPath : String?
	let firstAirDate : String?
	let genreIds : [Int]?
	let id : Int?
	let mediaType : String?
	let name : String?
	let originCountry : [String]?
	let originalLanguage : String?
	let originalName : String?
	let overview : String?
	let posterPath : String?
	let voteAverage : Double?
	let voteCount : Int?

	enum CodingKeys: String, CodingKey {

		case backdropPath = "backdrop_path"
		case firstAirDate = "first_air_date"
		case genreIds = "genre_ids"
		case id = "id"
		case mediaType = "media_type"
		case name = "name"
		case originCountry = "origin_country"
		case originalLanguage = "original_language"
		case originalName = "original_name"
		case overview = "overview"
		case posterPath = "poster_path"
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
		name = try values.decodeIfPresent(String.self, forKey: .name)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
	}

}
