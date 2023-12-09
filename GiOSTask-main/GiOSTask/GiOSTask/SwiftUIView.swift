//
//  SwiftUIView.swift
//  GiOSTask
//
//  Created by iSHIKA on 08/12/23.
//

import SwiftUI

struct HideScrollView: View {
    
    @State var initialOffset: CGFloat?
    @State var offset: CGFloat?
    @State var viewIsShown: Bool = true
    
    var body: some View {
        
        VStack{
            HStack {
                Text("Hide Me")
                Spacer()
            }.padding(.horizontal) .frame(height: 60) .background(Color.red) .foregroundColor(Color.white).opacity(self.viewIsShown ? 1 : 0)
            
            ScrollView {
                
                GeometryReader { geometry in
                    Color.clear.preference(key: OffsetKey.self, value: geometry.frame(in: .global).minY)
                        .frame(height: 0)
                }
                
                ForEach(0 ..< 20) { item in
                    VStack {
                        HStack {
                            Text("Content Items")
                            Spacer()
                        }.padding(.horizontal) .frame(height: 40)
                    }
                }
            }
        }.onPreferenceChange(OffsetKey.self) {
            if self.initialOffset == nil || self.initialOffset == 0 {
                self.initialOffset = $0
            }
            
            self.offset = $0
            
            guard let initialOffset = self.initialOffset,
                let offset = self.offset else {
                return
            }
            
                
                if(initialOffset > offset){
                    self.viewIsShown = false
                    print("hide")
                } else {
                    self.viewIsShown = true
                    print("show")
                }
            
        
            
        }
        
    }
}

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
