import Foundation
struct Actors : Codable {
	let adult : Bool?
	let gender : Int?
	let id : Int?
	let knownFor : [KnownFor]?
	let knownRorDepartment : String?
	let name : String?
	let popularity : Double?
	let profilePath : String?

	enum CodingKeys: String, CodingKey {

		case adult = "adult"
		case gender = "gender"
		case id = "id"
		case knownFor = "known_for"
		case knownRorDepartment = "known_for_department"
		case name = "name"
		case popularity = "popularity"
		case profilePath = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		gender = try values.decodeIfPresent(Int.self, forKey: .gender)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        knownFor = try values.decodeIfPresent([KnownFor].self, forKey: .knownFor)
        knownRorDepartment = try values.decodeIfPresent(String.self, forKey: .knownRorDepartment)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
	}

}
