//
//  HomeView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .loading:
                LoadingView()
            case let .error(errorDesc):
                Text(errorDesc)
            case .finished:
                homeConent
            }
        }
        .task {
            await viewModel.getData()
        }
        
    }
    
    var homeConent: some View {
        ZStack {
            VStack {
                HeaderView()
                SearchSubHeaderView(searchTxt: $viewModel.searchText,
                                    selectedValue: $viewModel.filterOption
                )
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                SliderView()
                ChartView(coinData: viewModel.cryptoData.first!, cryptoIcons: viewModel.cryptoIcons)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                CryptoList(coinDataList: viewModel.cryptoData, cryptoIcons: viewModel.cryptoIcons)
                Spacer(minLength: 60)
            }
            ZStack {
                VStack {
                    Spacer()
                    TabbarView()
                }
                VStack {
                    Spacer()
                    IconBtn(buttonIcon: TabBarOption.metaverse.icon) {
                    }
                }
            }
        }
        .onChange(of: viewModel.filterOption) { newValue in
            self.viewModel.changeWithFilter()
        }
        .onChange(of: viewModel.searchText) { newValue in
            self.viewModel.updateSearch()
        }
    }
}

#Preview {
    HomeView()
}
