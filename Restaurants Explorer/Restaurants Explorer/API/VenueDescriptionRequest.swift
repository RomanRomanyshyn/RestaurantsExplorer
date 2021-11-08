//
//  APIRequest.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 05.11.2021.
//

import Foundation
import CoreLocation

struct VenueDescriptionRequest {
    
    let api = "https://api.foursquare.com/v2"
    let endpoint = "/venues/"
    let clientId = "B00VD0CMXYC0552EOWHBWVGEKC5FU3QLOK3WRPA1X4DMZBF4"
    let clientSecret = "Z2H3ILHPDJH554PZSCEWVS3PZQUX0Z0ZYKLHZU3OQKYPS4YE"
    let venueId: String
        
    var date: String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyymmdd"
        return format.string(from: date)
    }
        
    var urlVenueDescription: String {
        let url = "\(api)\(endpoint)\(venueId)?client_id=\(clientId)&client_secret=\(clientSecret)&v=\(date)"
        return url
    }
    
    init(venueId: String) {
        self.venueId = venueId
    }
    
    typealias VenueDescriptionCompletion = (_ result: ServiceResult<VenueWithDescription, VenueError>) -> Void
    
    func loadVenueDescription(_ completion: @escaping VenueDescriptionCompletion) {
        guard let url = URL(string: urlVenueDescription) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let venueResponse = try decoder.decode(VenueDecriptionResponse.self, from: jsonData)
                let venue = venueResponse.venue
                completion(.success(venue))
            } catch {
                completion(.failure(.canNotProcessData))
            }
         
        }
        task.resume()
    }
}


