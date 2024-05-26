//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct ChartInfoView: View {
    var coinData: CoinData
    var cryptoIcons: [String: CryptoIconModel]
    var body: some View {
        CryptoCell(icon: cryptoIcons["\(coinData.id)"]?.logo ?? "", coinData: coinData).padding()
    }
}

#Preview {
    ChartInfoView(coinData: CoinData.mock, cryptoIcons: ["1": CryptoIconModel(logo: ""), "2": CryptoIconModel(logo: "")])
}
