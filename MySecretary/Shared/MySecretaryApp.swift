//
//  MySecretaryApp.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import Firebase

@main
struct MySecretaryApp: App {
   
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        setupFirebase()
    }
    
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

// MARK: Extension
private extension MySecretaryApp {
    func setupFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
}
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
