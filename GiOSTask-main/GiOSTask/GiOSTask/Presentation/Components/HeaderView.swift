//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            HeaderTextElement(headerTxt: StringConstants.exchangesTitle)
            Spacer()
            NotificationsButton()
            SettingsButton()
        }
    }
}

#Preview {
    HeaderView()
}
