//
//  ContentView.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            TabBarView()
        } else {
            SideBarView()
        }
        #else
        SideBarView()
        #endif
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        Group {
            ContentView().previewDevice("iPad Pro (12.9-inch) (4th generation)")
            ContentView().previewDevice("iPhone 12 Pro")
//            ContentView().previewDevice("Apple Watch Series 6 - 44mm")
        }
        #else
        ContentView().previewDevice("Mac")
        #endif
    }
}
