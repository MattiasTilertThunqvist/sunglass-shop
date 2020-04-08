//
//  NetworkError.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-26.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noDocument
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noDocument:
            return "Couldn't load document"
        }
    }
}
