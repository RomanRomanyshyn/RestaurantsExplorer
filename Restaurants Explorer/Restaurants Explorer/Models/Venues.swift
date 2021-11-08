//
//  Venue.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 05.11.2021.
//

import Foundation

struct VenueResponse: Codable {
    var response: Venues
}

struct Venues: Codable {
    var venues: [Venue]
}

struct Venue: Codable {
    var id: String
    var name: String?
    var location: LocationDetail
    var categories: [Category]
}

struct LocationDetail: Codable {
    var formattedAddress: [String]?
}

struct Category: Codable, Hashable {
    var name: String?
    var id: String?
}


