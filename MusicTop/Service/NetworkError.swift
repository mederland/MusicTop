//
//  NetworkError.swift
//  MusicTop
//
//  Created by Consultant on 7/23/22.
//

import Foundation

enum NetworkError: Error {
    case urlFailure
    case dataFailure
    case serverResponse (Int)
    case decodeError(Error)
    case other(Error)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlFailure:
            return NSLocalizedString("The url is not correct", comment: "URL failure")
        case .dataFailure:
            return NSLocalizedString("The data is empty or corrupted", comment: "Data failure")
        case .serverResponse(_):
            return NSLocalizedString("Server could not be reached, status code:", comment: "Servise Response Failure")
        case .decodeError:
            return NSLocalizedString("The data was fetched, contact your developer", comment: "Decode Error")
        case .other:
            return NSLocalizedString("Unknown", comment: "Other")
        
        }
    }
}

