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
            CryptoFeatureView(store: .init(initialState: .init(), reducer: {
                CryptoFeature()
            }))
        }
    }
}
