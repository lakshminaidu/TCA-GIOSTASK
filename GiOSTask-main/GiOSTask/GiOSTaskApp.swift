//
//  GiOSTaskApp.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct GiOSTaskApp: App {
    var body: some Scene {
        WindowGroup {
            CoinFeatureView(
                store: Store(initialState: CoinFeature.State(), reducer: {
                    CoinFeature()
                })
            )
        }
    }
}
