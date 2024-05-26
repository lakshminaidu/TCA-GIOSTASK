//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct TextElement: View {
    var text: String
    var fontSize: CGFloat
    var font: String
    var alignment: TextAlignment
    var body: some View {
        Text (text)
            .multilineTextAlignment(alignment)
            .font(Font.custom(font, size: fontSize))
    }
}

#Preview {
    TextElement(text: "ABC", fontSize: 18, font: AppFont.InterBlack.rawValue, alignment: .leading)
}
