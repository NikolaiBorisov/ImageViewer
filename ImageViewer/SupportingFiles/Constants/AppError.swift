//
//  AppError.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

enum AppError: Error {
    case failedParsingJSON
    case noInternetConnection
    case serverNotResponding
    case badURL
    case noData
    case somethingWrongWithUrlSessionData
    
    var title: String {
        switch self {
        case .failedParsingJSON:
            return "JSON Parsing Error"
        case .noInternetConnection:
            return "No Internet Connection"
        case .serverNotResponding:
            return "Server Is Not Responding"
        case .badURL:
            return "URL Is Not Valid"
        case .noData:
            return "No Data"
        case .somethingWrongWithUrlSessionData:
            return "Something Wrong With URL Session Data"
        }
    }
    
}
