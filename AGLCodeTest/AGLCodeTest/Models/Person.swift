import Foundation

typealias People = [Person]

struct Person : Codable {
	let name : String?
	let gender : Gender?
	let age : Int?
	let pets : [Pets]?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case gender = "gender"
		case age = "age"
		case pets = "pets"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
		age = try values.decodeIfPresent(Int.self, forKey: .age)
		pets = try values.decodeIfPresent([Pets].self, forKey: .pets)
	}

}
