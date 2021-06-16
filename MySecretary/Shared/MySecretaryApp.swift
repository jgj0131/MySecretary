//
//  MySecretaryApp.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import FirebaseAuth
import Firebase

@main
struct MySecretaryApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State var presentingModal = true
    
    init() {
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                ContentView()
            } else {
                ContentView()
                    .fullScreenCover(isPresented: $presentingModal, content: SignInView.init)
                    .animation(.none)
            }
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

// MARK: Extension
private extension MySecretaryApp {
    func setupFirebase() {
//        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
}
