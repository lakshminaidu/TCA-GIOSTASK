//
//  coinFeature.swift
//  GiOSTask
//
//  Created by iSHIKA on 02/12/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CoinFeature {
      @ObservableState
      struct State: Equatable {
        public static func == (lhs: CoinFeature.State, rhs: CoinFeature.State) -> Bool {
            lhs.id == rhs.id
        }
        private var id: UUID { UUID() }
        var filterOption: String = "ALL"
        var searchText: String = ""
        var isLoading: Bool = true
        var initialCoinData: [CoinData] = []
        var coinData: [CoinData] = []
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case processAPIResponse([CoinData])
        case updateCoinData([CoinData])
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    do {
                        let coinDataCopy: [CoinData] = try await self.request(endPoint: CoinRatesEndPoint.coinRates)
                        await send(.processAPIResponse(coinDataCopy))
                    } catch {
                    }
                }
            case let .processAPIResponse(data):
                state.isLoading = false
                state.initialCoinData = data.sorted {$0.cmcRank > $1.cmcRank}
                state.coinData = state.initialCoinData
                return .none
            case let .updateCoinData(data):
                state.coinData = data
                return .none
            case .binding(\.searchText):
                return .run { [state = state] send in
                    if state.searchText.isEmpty {
                        await send(.updateCoinData(state.initialCoinData))
                    } else {
                        await send(.updateCoinData(state.coinData.filter { $0.symbol.localizedCaseInsensitiveContains(state.searchText)}))
                    }
                }
            case .binding(\.filterOption):
                return .run { [state = state] send in
                    switch state.filterOption {
                    case FilterOption.price.rawValue:
                        return await send(.updateCoinData(state.coinData.sorted {$0.quote["USD"]!.price > $1.quote["USD"]!.price}))
                    case FilterOption.volume24h.rawValue:
                        return await send(.updateCoinData(state.coinData.sorted {$0.quote["USD"]!.volume24H > $1.quote["USD"]!.volume24H}))
                    default:
                        return await send(.updateCoinData(state.coinData.sorted {$0.cmcRank > $1.cmcRank}))
                    }
                }
            default: return .none
            }
        }
    }
}

extension CoinFeature: ApiManagerType {
    
}
