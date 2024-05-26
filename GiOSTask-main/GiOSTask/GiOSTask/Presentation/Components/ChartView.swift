//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    var coinData: CoinData
    var cryptoIcons: [String: CryptoIconModel]
    var body: some View {
        VStack {
            ChartInfoView(coinData: coinData, cryptoIcons: cryptoIcons )
            FilledLineChart(chartData: lineChartData)
                .frame(height: 60)
        }
        .background(Color.chartBackgroundColor)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    ChartView(coinData: CoinData.mock, 
              cryptoIcons: ["1": CryptoIconModel(logo: ""),
                            "2": CryptoIconModel(logo: "")]
             )
             .padding(.horizontal, 30)
}
