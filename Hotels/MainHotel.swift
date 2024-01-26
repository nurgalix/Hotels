//
//  MainHotel.swift
//  Hotels
//
//  Created by Nurgali on 20.12.2023.
//

import Foundation

// MARK: - MainHotel
struct MainHotel: Decodable {
    let id: Int
    let name, adress: String
    let minimal_price: Int
    let price_for_it: String
    let rating: Int
    let rating_name: String
    let image_urls: [String]
    let about_the_hotel: AboutTheHotel

//    enum CodingKeys: String, CodingKey {
//        case id, name, adress
//        case minimalPrice
//        case priceForIt
//        case rating
//        case ratingName
//        case imageUrls
//        case aboutTheHotel
//    }
}

// MARK: - AboutTheHotel
struct AboutTheHotel: Decodable {
    let description: String
    let peculiarities: [String]
}
