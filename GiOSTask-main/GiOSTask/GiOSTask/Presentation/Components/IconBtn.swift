//
//  IconBtn.swift
//  GiOSTask
//
//  Created by iSHIKA on 17/11/23.
//

import SwiftUI

struct IconBtn: View {
    var buttonIcon: String
    let action: () -> Void
    
    var body: some View {
            Button(action: {
                action()
            }) {
                Image(buttonIcon)
                    .padding(.bottom,-25) // Because metaverse icon is not centered in  png  itself from figma
            }
            .background(Color.clear)
            .buttonStyle(BorderlessButtonStyle())
            .frame(alignment: .center)
            
        }
}

#Preview {
    IconBtn(buttonIcon: TabBarOption.metaverse.icon){}
}
