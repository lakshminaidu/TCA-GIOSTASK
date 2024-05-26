//
//  HomeViewModel.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import Foundation
enum HomeViewState: Equatable {
    case loading
    case finished
    case error(String)
}
enum FilterOption: String, CaseIterable {
    case price = "Price"
    case volume24h = "24H Volume"
    case all = "ALL"
}

@MainActor final class HomeViewModel: ObservableObject {
    @Published private (set) var viewState: HomeViewState = .loading
    @Published private (set) var cryptoData: [CoinData] = []
    @Published private (set) var cryptoIcons: [String: CryptoIconModel] = [:]
    @Published var filterOption: String = "ALL"
    @Published var searchText: String = ""
    private (set) var cryptoDataCopy: [CoinData] = []
    
    func getData() async {
        do {
            self.cryptoDataCopy = try await self.request(endPoint: CoinRatesEndPoint.coinRates)
            self.cryptoData = self.cryptoDataCopy.sorted {$0.cmcRank > $1.cmcRank}
            await getIcons()
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
    
    func getIcons() async {
        let ids = cryptoData.compactMap { "\($0.id)" }.joined(separator: ",")
        do {
            cryptoIcons = try await self.request(endPoint: CoinRatesEndPoint.icon(ids))
            viewState = .finished
        } catch {
            viewState = .finished
        }
    }
    
    func changeWithFilter() {
        switch self.filterOption {
        case FilterOption.price.rawValue:
            self.cryptoData = self.cryptoData.sorted {$0.quote["USD"]!.price > $1.quote["USD"]!.price }
        case FilterOption.volume24h.rawValue:
            self.cryptoData = self.cryptoData.sorted {$0.quote["USD"]!.volume24H > $1.quote["USD"]!.volume24H }
        default:
            self.cryptoData = self.cryptoData.sorted {$0.cmcRank > $1.cmcRank}
        }
    }
    
    func updateSearch() {
        if self.searchText.isEmpty {
            self.cryptoData = self.cryptoDataCopy
        } else {
            self.cryptoData = self.cryptoDataCopy.filter { $0.symbol.localizedCaseInsensitiveContains(self.searchText)}
        }
        changeWithFilter()
    }
}

extension HomeViewModel: ApiManagerType { }
