//
//  ContentView.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices

struct ContentView: View {
    @Binding var presentingModal: Bool

    var body: some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            TabBarView(presentingModal: $presentingModal).accentColor(Color(UIColor.label))
        } else {
            SideBarView(presentingModal: $presentingModal).accentColor(Color(UIColor.label))
        }
        #else
        SideBarView(presentingModal: $presentingModal).accentColor(Color(NSColor.labelColor))
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        Group {
            ContentView(presentingModal: .constant(true)).previewDevice("iPad Pro (12.9-inch) (4th generation)")
            ContentView(presentingModal: .constant(true)).previewDevice("iPhone 12 Pro")
//            ContentView().previewDevice("Apple Watch Series 6 - 44mm")
//            ContentView().previewDevice("Mac")
        }
        #else
        ContentView(presentingModal: .constant(true)).previewDevice("Mac")
        #endif
    }
}
