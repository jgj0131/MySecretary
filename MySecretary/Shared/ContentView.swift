//
//  ContentView.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

struct ContentView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
   
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            TabBarView().accentColor(Color(UIColor.label))
        } else {
            SideBarView().accentColor(Color(UIColor.label))
        }
        #else
        SideBarView().accentColor(Color(NSColor.labelColor))
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        Group {
            ContentView().previewDevice("iPad Pro (12.9-inch) (4th generation)")
            ContentView().previewDevice("iPhone 12 Pro")
//            ContentView().previewDevice("Apple Watch Series 6 - 44mm")
//            ContentView().previewDevice("Mac")
        }
        #else
        ContentView().previewDevice("Mac")
        #endif
    }
}
