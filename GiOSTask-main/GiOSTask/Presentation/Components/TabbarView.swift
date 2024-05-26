//
//  TabbarView.swift
//  GiOSTask
//
//  Created by iSHIKA on 17/11/23.
//

import SwiftUI

enum TabBarOption: Int, Codable, CaseIterable, Equatable {
    case shop
    case exchange
    case metaverse
    case launchpad
    case wallet
    
    var title: String {
        switch self {
        case .shop:
            return StringConstants.shopTabTitle
        case .exchange:
            return StringConstants.exchangeTabTitle
        case .metaverse:
            return ""
        case .launchpad:
            return StringConstants.launchPadsTabTitle
        case .wallet:
            return StringConstants.walletTabTitle
        }
    }
    
    var icon: String {
        switch self {
        case .shop:
            return AppIcons.shopIc.rawValue
        case .exchange:
            return AppIcons.exchangeIc.rawValue
        case .metaverse:
            return AppIcons.metaverseIc.rawValue
        case .launchpad:
            return AppIcons.launchpadIc.rawValue
        case .wallet:
            return AppIcons.walletIc.rawValue
        }
    }
}

struct TabbarView: View {
    var body: some View {
        ZStack {
            HStack {
                ForEach(TabBarOption.allCases, id: \.self) { tab in
                    Group {
                        Spacer()
                        if tab == TabBarOption.metaverse {
                            TabBtn(buttonTitle: "", buttonIcon: "", isSelected: false){}
                        } else {
                            TabBtn(buttonTitle: tab.title, buttonIcon: tab.icon, isSelected: tab == TabBarOption.exchange) { }
                        }
                        Spacer()
                    }
                 
                }
            }
            .background(.black)
            .clipShape(.rect(cornerRadius: 25))
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }
        .background(.clear)
    }
}

#Preview {
    TabbarView()
}
