//
//  MySecretaryApp.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

@main
struct MySecretaryApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.onChange(of: scenePhase, perform: { phase in
            switch scenePhase {
            case .active:
                print("active")
            case .background:
                print("background")
            case .inactive:
                print("inactive")
            default:
                print("none")
            }
        })
    }
}
