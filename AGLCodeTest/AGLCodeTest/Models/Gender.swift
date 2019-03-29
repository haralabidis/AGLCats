import Foundation

enum Gender: String, Codable {
    case Male = "Male"
    case Female = "Female"
    case other
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = Gender(rawValue: label) ?? .other
    }
}

