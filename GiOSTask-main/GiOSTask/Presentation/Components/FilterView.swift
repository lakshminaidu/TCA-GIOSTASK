//
//  FilterView.swift
//  GiOSTask
//
//  Created by iSHIKA on 17/11/23.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedValue: String
    var dataSource: [String]
    
    var body: some View {
        Menu {
            Picker(selection: $selectedValue, label: EmptyView()) {
                ForEach(dataSource, id: \.self) { key in
                    Text(key)
                        .tag(key)
                }
            }
        } label: {
            HStack {
                Image(systemName: "line.3.horizontal.decrease")
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 0))
                    .scaleEffect(1.2)
                    .foregroundColor(Color.filterBtnColor)
                Text (selectedValue == "ALL" ? "Filter" : selectedValue)
                    .font(Font.custom(AppFont.InterBold.rawValue, size: 13))
                    .foregroundColor(Color.filterBtnColor)
                    .padding(.trailing, 20)
            }
            .overlay{
                Capsule()
                    .stroke(Color.filterBtnColor, lineWidth: 1)
            }
        }
        .accessibilityLabel("Selected \(selectedValue)")
    }
    
}

#if DEBUG
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(selectedValue: .constant("Price"), dataSource: FilterOption.allCases.map {$0.rawValue})
    }
}
#endif
