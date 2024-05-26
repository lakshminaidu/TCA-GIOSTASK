//
//  asd.swift
//  GiOSTask
//
//  Created by iSHIKA on 17/11/23.
//

import Foundation

enum CoinRatesEndPoint {
    case coinRates
    case icon(String)
}

// MARK: - CoinRatesEndPoint
// Endpoint for coinRates
extension CoinRatesEndPoint: Endpoint {
    var queryItems: [URLQueryItem] {
        switch self {
        case .coinRates:
            return []
        case let .icon(id):
            return [URLQueryItem(name: "id", value: id)]
        }
    }
    
    var path: String {
        switch self {
        case .coinRates:
          return "/v1/cryptocurrency/listings/latest"
        case .icon:
            return "/v2/cryptocurrency/info"
        }
    }
}
