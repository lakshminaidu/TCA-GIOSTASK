//
//  ContentView.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import SwiftUI

struct SearchSubHeaderView: View {
    @Binding var searchTxt: String
    @Binding var selectedValue: String
    var body: some View {
        
        HStack {
            HStack {
                Image(AppIcons.searchIc.rawValue)
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 0))
                    .scaleEffect(1.2)
                TextField("Search Cryptocurrency",text: $searchTxt )
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.leading)
            }
            .background(Color.searchFieldBackground)
            .clipShape(Capsule())
            FilterView(selectedValue: $selectedValue, dataSource: FilterOption.allCases.map {$0.rawValue})
        }
        
    }
}

#Preview {
    SearchSubHeaderView(searchTxt: .constant("asdasd"), selectedValue: .constant("ALL"))
}
