//
//  VenueDescription.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 07.11.2021.
//

import Foundation

struct VenueDecriptionResponse: Codable {
    var response: Response
}

struct Response: Codable {
    var venue: VenueWithDescription
}

struct VenueWithDescription: Codable {
    var description: String?
    var id: String?
}
