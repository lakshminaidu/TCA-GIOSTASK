//
//  CoinFeature.swift
//  GiOSTask
//
//  Created by Lakshminaidu Chilakala on 27/11/2023.
//

import Foundation
import ComposableArchitecture

enum FilterOption: String, CaseIterable {
    case price = "Price"
    case volume24h = "24H Volume"
    case all = "ALL"
}

@Reducer
struct CryptoFeature {
    struct State: Equatable {
        static func == (lhs: CryptoFeature.State, rhs: CryptoFeature.State) -> Bool {
            lhs.id == rhs.id
        }
        
        private var id: UUID  { UUID() }
        var filterOption: String = "ALL"
        var searchText: String = ""
        var isLoading = true
        var initialCryptoData: [CryptoData] = []
        var cryptoData: [CryptoData] = []
    }
    
    enum Action {
        case onAppear // fetch data
        case processAPIResponse([CryptoData]) // process API response
        case updateCryptoData // updates data when filter change or search change
        case search(String) // update data while searching
        case filterBy(String) // update data with filter change
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    do {
                        let cryptoDataCopy: [CryptoData] = try await self.request(endPoint: CoinRatesEndPoint.coinRates)
                        await send(.processAPIResponse(cryptoDataCopy))
                    } catch {
                    }
                }
            case let .processAPIResponse(data):
                state.isLoading = false
                state.initialCryptoData = data
                state.cryptoData = data
                return .none
            case .updateCryptoData:
                var tempData = state.initialCryptoData
                if !state.searchText.isEmpty {
                    tempData = state.initialCryptoData.filter { $0.symbol.localizedCaseInsensitiveContains(state.searchText)}
                }
                switch state.filterOption {
                case FilterOption.price.rawValue:
                    tempData = tempData.sorted {$0.quote["USD"]!.price > $1.quote["USD"]!.price}
                case FilterOption.volume24h.rawValue:
                    tempData = tempData.sorted {$0.quote["USD"]!.volume24H > $1.quote["USD"]!.volume24H}
                default:
                    tempData = tempData.sorted {$0.cmcRank > $1.cmcRank}
                }
                state.cryptoData = tempData
                return .none
            case let .search(query):
                state.searchText = query
                return .run { send in
                    await send(.updateCryptoData)
                }
            case let .filterBy(filter):
                state.filterOption = filter
                return .run { send in
                    await send(.updateCryptoData)
                }
            }
        }
    }
}

extension CryptoFeature: ApiManagerType {
    
}
