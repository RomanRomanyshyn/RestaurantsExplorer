//
//  APIRequest.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 05.11.2021.
//

import Foundation
import CoreLocation

typealias VenuesCompletion = (_ result: ServiceResult<[Venue], VenueError>) -> Void
typealias VenueDescriptionCompletion = (_ result: ServiceResult<VenueWithDescription, VenueError>) -> Void

enum ServiceResult<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    public init(_ value: Value) {
        self = .success(value)
    }
    
    public init(_ error: Error) {
        self = .failure(error)
    }
}

enum VenueError: String, Error {
    case noDataAvailable = "No data Available"
    case canNotProcessData = "Can not Process Data"
}

struct VenueRequest {
    
    private let api = "https://api.foursquare.com/v2/venues/"
    private let endpoint = "search"
    
    private let clientId = "NX4HTL42MUZALBBWGOI4Q2ABH032VXZIKJS4X2X1P4QNFNLC"
    private let clientSecret = "5RAQQ3EFSHOPZOTYD22COM3CEUPWXRHFBMSXO1A50FGP0YMA"
    
//    You can use it if previous credentials doesn't work
//    private let clientId = "CQ3BKBHVFSVY1AQTFOI4HWIMLJMDWUPXGF22QEHM4MZ033BZ"
//    private let clientSecret = "BQMVNQPY3VK2D0K14BX0LQFCSYRIF4LKRK3YMF1GYP121FNT"
    
//    private let clientId = "B00VD0CMXYC0552EOWHBWVGEKC5FU3QLOK3WRPA1X4DMZBF4"
//    private let clientSecret = "Z2H3ILHPDJH554PZSCEWVS3PZQUX0Z0ZYKLHZU3OQKYPS4YE"

        
    private var date: String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyymmdd"
        return format.string(from: date)
    }
        
    private func urlVenues(location: CLLocationCoordinate2D) -> String {
        let url = "\(api)\(endpoint)?client_id=\(clientId)&client_secret=\(clientSecret)&v=\(date)&ll=\(location.latitude),\(location.longitude)"
        return url
    }
    
    private func urlVenueDescription(venueId: String) -> String {
        let url = "\(api)\(venueId)?client_id=\(clientId)&client_secret=\(clientSecret)&v=\(date)"
        return url
    }
    
    func loadVenues(location: CLLocationCoordinate2D, _ completion: @escaping VenuesCompletion) {
        guard let url = URL(string: urlVenues(location: location)) else {
            completion(.failure(.noDataAvailable))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let venuesResponse = try decoder.decode(VenueResponse.self, from: jsonData)
                let venues = venuesResponse.response.venues
                completion(.success(venues))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
    
    func loadVenueDescription(venueId: String, _ completion: @escaping VenueDescriptionCompletion) {
        guard let url = URL(string: urlVenueDescription(venueId: venueId)) else {
            completion(.failure(.noDataAvailable))
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
                let venue = venueResponse.response.venue
                completion(.success(venue))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
}

