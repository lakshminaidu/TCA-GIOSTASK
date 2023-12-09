//
//  CoinFeatureView.swift
//  GiOSTask
//
//  Created by Lakshminaidu Chilakala on 29/11/2023.
//

import SwiftUI
import ComposableArchitecture


struct CryptoFeatureView: View {
    let store: StoreOf<CryptoFeature>
    @State private var scrollPosition: CGPoint = .zero
    @State private var showHeader: Bool = false

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.isLoading {
                    LoadingView()
                } else {
                    VStack {
                        Text(StringConstants.exchangesTitle)
                            .font(Font.custom(AppFont.InterBold.rawValue, size: 20))
                        ScrollView {
                            SearchSubHeaderView(searchTxt: viewStore.binding(
                                get: \.searchText,
                                send: { .search($0)}
                            ),
                                                selectedValue: viewStore.binding(
                                                    get: \.filterOption,
                                                    send: { .filterBy($0)}
                                                )
                            )
                            ForEach(viewStore.cryptoData, id: \.id) { data in
                                CryptoCell(cryptoData: data)
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
