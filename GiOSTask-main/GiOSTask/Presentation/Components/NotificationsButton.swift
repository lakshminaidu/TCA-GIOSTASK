//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct NotificationsButton: View {
    var body: some View {
        Button(action: {
            
        }) {
            ZStack(alignment: .topTrailing) {
                VStack {
                    Image(AppIcons.notificationIc.rawValue)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                }
                VStack {
                    Image(AppIcons.indicator.rawValue)
                    
                }
                
            }
            
        }
    }
}

#Preview {
    NotificationsButton()
}
