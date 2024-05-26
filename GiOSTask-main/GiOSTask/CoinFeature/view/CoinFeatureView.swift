//
//  CoinFeatureView.swift
//  GiOSTask
//
//  Created by iSHIKA on 02/12/23.
//

import SwiftUI
import ComposableArchitecture

struct CoinFeatureView: View {
    @State var store: StoreOf<CoinFeature>
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                SearchSubHeaderView(searchTxt: $store.searchText,
                                    selectedValue: $store.filterOption
                )
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                CryptoList(coinDataList: store.coinData, cryptoIcons: [:])
            }
            .overlay {
                VStack {
                    Spacer()
                    TabbarView()
                        .overlay {
                            IconBtn(buttonIcon: TabBarOption.metaverse.icon) {
                            }
                            .offset(y: -20)
                        }
                }
            }
            if store.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

struct CoinList: View {
    var coinDataList: [CoinData]
    var body: some View {
        VStack {
            HStack {
                TextElement(text: "Top Currencies", fontSize: 16, font: AppFont.InterBold.rawValue, alignment: .leading)
                    .foregroundColor(Color.black)
                Spacer()
                TextElement(text: "View All", fontSize: 12, font: AppFont.InterBold.rawValue, alignment: .trailing)
                    .foregroundColor(Color.filterBtnColor)
            }
            .padding([.horizontal, .top], 16)
            .padding([.bottom], 4)
            
            List {
                ForEach(coinDataList, id: \.id) { data in
                    CoinRow(coinData: data)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .background(Color.clear)
            .listRowBackground(Color.clear)
        }
        
    }
}

struct CoinRow: View {
    var coinData: CoinData
    var body: some View {
        HStack {
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
    CoinRow(coinData: CoinData.mock).padding()
}


#Preview {
    CryptoList(coinDataList: CoinData.mockList, cryptoIcons: ["1": CryptoIconModel(logo: ""), "2": CryptoIconModel(logo: "")])
}


enum HomeViewState: Equatable {
    case loading
    case finished
    case error(String)
}
