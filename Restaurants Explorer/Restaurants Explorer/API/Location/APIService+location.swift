////
////  APIService+location.swift
////  Restaurants Explorer
////
////  Created by Роман Романишин on 05.11.2021.
////
//
//import Foundation
//
////typealias WeatherCompletion = (_ result: ServiceResult<WeatherForDays, ServiceError>) -> Void
//typealias LocationCompletion = (_ result: ServiceResult<[Venue], ServiceError>) -> Void
//
//protocol WeatherAPIServiceInput {
//    func loadLocation(_ completion: @escaping LocationCompletion)
////    func loadWeather(_ completion: @escaping WeatherCompletion)
//}
//
//extension APIService: WeatherAPIServiceInput {
//    func loadLocation(_ completion: @escaping LocationCompletion) {
////        guard let url = URL(string: APIService.apiTest) else { return }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let httpResponse = response as? HTTPURLResponse else { return }
//            self?.handleServerCodes(httpResponse.statusCode, completion: { (validation) in
//                switch validation {
//                case .success:
//                    do {
//                        guard let data = data else { return }
////                        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
////                        guard let responseDictionary = response?[0] as? [String: Any] else { return }
//                         let decoder = JSONDecoder()
////                         let correctData = try JSONSerialization.data(withJSONObject: responseDictionary, options: [])
//                        let location = try decoder.decode(VenueResponse.self, from: data)
//                        let locationDetails = location.response.venues
//                        
//                        completion(ServiceResult(locationDetails))
//                    } catch let err {
//                        completion(ServiceResult(ServiceError.message(errorMessage: err.localizedDescription)))
//                    }
//                    
//                case .failure(let reason):
//                    print(reason)
//                case .internalServerError:
//                    print("internalServerError")
//                case .unknown:
//                    print("unknown")
//                }
//            })
//        }
//        task.resume()
//    }
//}
