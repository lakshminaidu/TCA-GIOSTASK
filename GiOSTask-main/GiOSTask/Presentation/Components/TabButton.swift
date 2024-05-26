//
//  TabButton.swift
//  GiOSTask
//
//  Created by iSHIKA on 17/11/23.
//

import SwiftUI

struct TabBtn: View {
    let buttonTitle: String
    let buttonIcon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
           action()
        }){
            VStack {
                Image(buttonIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonTitle.count > 0 ? 20: 70,height: buttonTitle.count > 0 ? 20: 70)
                if buttonTitle.count > 0 {
                    Text(buttonTitle)
                        .font(Font.custom(AppFont.InterRegular.rawValue, size: 9))
                        .foregroundColor(isSelected ? .white: Color.tabDisabledColor)
                        .frame(alignment: .center)
                        .lineLimit(1)
                }
            }
        }
        .padding(EdgeInsets(top: buttonTitle.count > 0 ? 10: 0, leading:buttonTitle.count > 0 ? 5 : 0, bottom: buttonTitle.count > 0 ? 10:0, trailing: buttonTitle.count > 0 ? 5 : 0))
        .background(.black)
        .buttonStyle(.borderless)
        
    }
}

#Preview {
    TabBtn(buttonTitle: StringConstants.walletTabTitle, buttonIcon: TabBarOption.wallet.icon, isSelected: false) { }
}
