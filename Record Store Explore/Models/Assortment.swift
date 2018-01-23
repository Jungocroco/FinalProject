
import UIKit

struct Assortment: Codable {
    var image: String
    var title: String
    var artist: String
    var label: String
    var price: String
    var state: String


    enum CodingKeys: String, CodingKey {
        case image
        case title
        case artist
        case label
        case price
        case state
    }
}

struct RecordsArray: Codable {
    let recordsArray: [Assortment]
}

