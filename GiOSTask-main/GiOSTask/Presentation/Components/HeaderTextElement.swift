//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct HeaderTextElement: View {
    var headerTxt: String
    var body: some View {
        Text(StringConstants.exchangesTitle)
            .font(Font.custom(AppFont.InterBold.rawValue, size: 20))
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 10))
    }
}

#Preview {
    HeaderTextElement(headerTxt: StringConstants.exchangesTitle)
}
