//
//  ApiManager.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import Foundation

// Protocol defining a common interface for making network requests and decoding responses.
protocol ApiManagerType {
    ///  Making
    /// - Parameters:
    ///   - endPoint: Endpoint of type
    ///   - urlSession:  configured Session is an optional
    /// - Returns: returns the decodable of type model
    func request<T: Decodable>(endPoint: Endpoint) async throws -> T
}

extension ApiManagerType {
    // Default implementation for the request method within the WebServiceType protocol.

    func request<T: Decodable>(endPoint: Endpoint) async throws -> T {
        // preparing a URLRequest for the provided URL.
        let request = endPoint.urlRequest
        print("Sending request to \(request.url?.absoluteString ?? "")")
        let dataAndResponse: (data: Data?, response: URLResponse) = try await URLSession.shared.data(for: request)
        
        print("Received response from \(request.url?.absoluteString ?? "")")
        // Ensuring the response is an HTTPURLResponse and the status code is in the success range.
        guard let response = dataAndResponse.response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        guard (200..<300) ~= response.statusCode else { throw ApiError.invalidResponse}
        
        // Retrieve the data from the response.
        guard let data = dataAndResponse.data else { throw ApiError.noResponse }
        #if DEBUG
        // Convert the received data to a JSON string for logging
        if let jsonString = data.prettyJson {
            print("Received Response as JSON:\n\(jsonString)")
        }
        #endif
        do {
            // decoding data to model with data decoding strategy
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResponseData<T>.self, from: data)
            return result.data
        } catch {
            throw ApiError.decodingError(description: error.localizedDescription)
        }
    }
    
}

extension Data {
    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }

        return prettyPrintedString
    }
}



enum ApiError: Equatable {
    case invalidURL
    case noResponse
    case requestFailed
    case invalidResponse
    case connectionError
    case decodingError(description: String)
    case custom(description: String)
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Unable to perform the request", comment: "invalidURL")
        case .invalidResponse:
            return NSLocalizedString("There is no valid data, please try again.", comment: "invalidResponse")
        case .requestFailed, .noResponse:
            return NSLocalizedString("Sorry for the inconvinience, server is not reachable.", comment: "decodingError")
        case .connectionError:
            return NSLocalizedString("Your internet connection appears to be offline. Please try again.", comment: "connectionError")
        case .decodingError(let message):
            return NSLocalizedString("Unable to decode \(message)", comment: "decodingError")
        case .custom(description: let description):
            return NSLocalizedString(description, comment: "custom")
        }
    }
}
