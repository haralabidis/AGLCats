
import Foundation
struct Pets : Codable {
	let name : String?
	let type : PetType?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(PetType.self, forKey: .type)
	}

}
