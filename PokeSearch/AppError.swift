//
//  AppError.swift
//  PokeSearch
//
//  Created by Andre Veltens on 22.02.26.
//

import Foundation

enum AppError: LocalizedError {
    case networkError(Error)
    case decodingError(Error)
    case audioError(Error)
    case audioConversionFailed
    
    var errorDescription: String? {
        switch self {
            case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .audioError(let error):
            return "Audio error: \(error.localizedDescription)"
        case .audioConversionFailed:
            return "Failed to convert audio"
        }
    }
}
