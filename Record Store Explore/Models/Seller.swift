//
//  Seller.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 25-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

struct Seller: Codable {
    var username: [String]
    
    enum CodingKeys: String, CodingKey {
        case username
    }
}

//struct SellerArray: Codable {
//    var
//}

