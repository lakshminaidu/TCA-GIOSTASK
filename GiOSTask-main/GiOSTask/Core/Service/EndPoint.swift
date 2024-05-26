//
//  EndPoint.swift
//  GiOSTask
//
//  Created by iSHIKA on 17/11/23.
//

import Foundation
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var urlRequest: URLRequest {get}
}

extension Endpoint {

    var scheme: String {
        return "https"
    }
    var host: String {
        return "pro-api.coinmarketcap.com"
    }
    var urlRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        var request =  URLRequest(url: urlComponents.url!)
        request.setValue(AppConstants.apikey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        return request
    }
}
