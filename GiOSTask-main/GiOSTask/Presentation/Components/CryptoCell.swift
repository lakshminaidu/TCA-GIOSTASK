//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct CryptoCell: View {
    var icon: String
    var coinData: CoinData
    var body: some View {
        HStack {
            NetworkImageView(imageURL: URL(string: "pro.coinmarketcap.com\(icon).png"))
                .frame(width: 64,height:64)
            
            VStack {
                HStack {
                    TextElement(text: coinData.symbol, fontSize: 18, font: AppFont.InterBold.rawValue, alignment: .leading)
                    Image((coinData.isGrowing ? AppIcons.greenChart : AppIcons.redChart).rawValue)
                        .resizable()
                        .frame(width: 50, height: 20)
                    Spacer()
                          TextElement(text: "$\(coinData.getPrice()) USD", fontSize: 16, font: AppFont.InterBold.rawValue, alignment: .trailing)
                        .padding(.trailing,20)
                    
                }
                HStack {
                    TextElement(text: coinData.name, fontSize: 13, font: AppFont.InterSemiBold.rawValue, alignment: .leading)
                    Spacer()
                        TextElement(text: String(format:"%.2f", coinData.getPercentage()), fontSize: 13, font: AppFont.InterSemiBold.rawValue, alignment: .trailing)
                        .padding(.trailing,20)
                        .foregroundColor(coinData.getPercentage() < 0 ? .red : Color.chartPercentageColor)
                }
            }
        }
    }
    
}

#Preview {
    CryptoCell(icon: "", coinData: CoinData.mock).padding()
}
