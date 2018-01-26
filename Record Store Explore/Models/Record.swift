
import UIKit

struct Listing: Codable {
    var release: Release
    var condition: String
    var status: String
    var price: Price

    enum CodingKeys: String, CodingKey {
        case release
        case price
        case condition
        case status
    }
}

struct RecordsArray: Codable {
    let listings: [Listing]
}

struct Price: Codable {
    let value: Double
}

struct Release: Codable {
    let thumbnail: String
    let artist: String
    let title: String
    let year: Int
    let catalog_number: String
}



