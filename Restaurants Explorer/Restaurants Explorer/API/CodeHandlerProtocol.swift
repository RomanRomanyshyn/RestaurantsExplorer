//
//  CodeHandlerProtocol.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 05.11.2021.
//

import Foundation

enum HTTPStatusCode: Int {
    case success = 200
    case created = 201
    case internalServerError = 500
}

enum CodeValidation {
    case success
    case failure(reason: String)
    case internalServerError
    case unknown
}

typealias CodeValidationCompletion = (_ result: CodeValidation) -> Void

protocol CodeHandlerProtocol {
    func handleServerCodeWithMessage(_ code: Int, _ message: String, completion: @escaping CodeValidationCompletion)
    func handleServerCodes(_ code: Int, completion: @escaping CodeValidationCompletion)
}
