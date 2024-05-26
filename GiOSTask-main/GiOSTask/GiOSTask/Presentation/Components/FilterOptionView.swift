//
//  SliderView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

enum SliderOption: Int {
    case cryptoCurrecy = 1
    case nft = 2
}

struct SliderView: View {
    @State private var selectedOption: Int = 1
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                Button(action: {
                    selectedOption = SliderOption.cryptoCurrecy.rawValue
                }) {
                    Text("Cryptocurrency")
                        .font(Font.custom(AppFont.InterBold.rawValue, size: 20))
                        .foregroundColor(selectedOption == SliderOption.cryptoCurrecy.rawValue ? .black : Color.filterBtnColor)
                }
                
                Button(action: {
                    selectedOption = SliderOption.nft.rawValue
                }) {
                    Text("NFT")
                        .font(Font.custom(AppFont.InterBold.rawValue, size: 20))
                        .foregroundColor(selectedOption == SliderOption.nft.rawValue ? .black : Color.filterBtnColor)
                }
            }
        }
        .padding(.leading,20)
    }
}

#Preview {
    SliderView()
}
