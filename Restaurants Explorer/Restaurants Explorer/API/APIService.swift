////
////  APIService.swift
////  Restaurants Explorer
////
////  Created by Роман Романишин on 05.11.2021.
////
//
//import UIKit
//
//typealias APIServiceInput = WeatherAPIServiceInput
//
//enum ServiceResult<Value, Error: Swift.Error> {
//    case success(Value)
//    case failure(Error)
//    
//    public init(_ value: Value) {
//        self = .success(value)
//    }
//    
//    public init(_ error: Error) {
//        self = .failure(error)
//    }
//}
//
//enum ServiceError: Error {
//    case message(errorMessage: String)
//    case undefined
//}
//
//class APIService {
//    static let api = "https://api.foursquare.com/v2/venues"
////    static let apiTest = VenueRequest().url
//}
//
//extension APIService: CodeHandlerProtocol {
//    func handleServerCodeWithMessage(_ code: Int, _ message: String, completion: @escaping CodeValidationCompletion) {
//        switch HTTPStatusCode(rawValue: code) {
//        case .success?, .created?:
//            completion(.success)
//        case .internalServerError?:
//            completion(.internalServerError)
//        default:
//            completion(.unknown)
//        }
//    }
//    
//    func handleServerCodes(_ code: Int, completion: @escaping CodeValidationCompletion) {
//        switch HTTPStatusCode(rawValue: code) {
//        case .success?, .created?:
//            completion(.success)
//        case .internalServerError?:
//            completion(.internalServerError)
//        default:
//            completion(.unknown)
//        }
//    }
//}
//
