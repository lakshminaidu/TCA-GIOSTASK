//
//  CoionModel.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import Foundation
struct ResponseData<T: Decodable>: Decodable {
    var status: Status?
    var data: T
}

// MARK: - Datum
struct CryptoData: Codable {
    var id: Int
    var name: String
    var symbol: String
    var quote: [String: QuoteDetail]
    var cmcRank: Int

    enum CodingKeys: String, CodingKey {
        case id
        case cmcRank = "cmc_rank"
        case name
        case symbol
        case quote
    }
    
    func getPercentage() -> Double {
        guard let change = quote["USD"]?.percentChange24H else { return 0.0 }
        return Double(change)
    }
    
    func getPrice() -> String {
        guard let price = quote["USD"]?.price else { return "" }
        return String(format: "%.2f", price)
    }
    
    var isGrowing: Bool {
       guard let percentChange24H = quote["USD"]?.percentChange24H else { return false }
        return percentChange24H > 0
    }
}


// MARK: - Usd
struct QuoteDetail: Codable {
    var price: Double
    var volume24H: Double
    var percentChange24H: Double
    
    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume_24h"
        case percentChange24H = "percent_change_24h"
    }
}

extension QuoteDetail {
    var isGrowing: Bool { percentChange24H > 0 }
}

// MARK: - Status
struct Status: Codable {
    var elapsed: Int?
    var notice, errorMessage: String?
    var errorCode, creditCount: Int?
    var timestamp: String?
    var totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case elapsed, notice
        case errorMessage = "error_message"
        case errorCode = "error_code"
        case creditCount = "credit_count"
        case timestamp
        case totalCount = "total_count"
    }
}




extension CryptoData {
    static let mockCoin: CryptoData = CryptoData(id: 1,
                                             name: "Bitcoin",
                                             symbol: "BTC",
                                             quote: ["USD": QuoteDetail(price: 36382.4227,
                                                                         volume24H: 26184010295.475838,
                                                                         percentChange24H: -2.55499761)], 
                                                 cmcRank: 1)
    
    static let mockList: [CryptoData] = [CryptoData(id: 1,
                                             name: "Bitcoin",
                                             symbol: "BTC",
                                             quote: ["USD" : QuoteDetail(price: 36382.4227, volume24H: 26184010295.475838 , percentChange24H: -2.55499761)], cmcRank: 1),
                                     CryptoData(id: 2,
                                                name: "ABCD",
                                                symbol: "ABC",
                                                quote: ["USD": QuoteDetail(price: 36382.4227,
                                                                            volume24H: 26184010295.475838,
                                                                            percentChange24H: 2.55499761)],
                                                cmcRank: 2)
    ]
}
