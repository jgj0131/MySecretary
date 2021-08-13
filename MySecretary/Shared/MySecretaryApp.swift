//
//  MySecretaryApp.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
//import FirebaseAuth
//import Firebase

@main
struct MySecretaryApp: App {
//    @Environment(\.scenePhase) private var scenePhase
//    @State var presentingModal = true
    
//    init() {
//        setupFirebase()
//    }
    private let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
//        WindowGroup {
//            if Auth.auth().currentUser != nil {
//                ContentView(presentingModal: $presentingModal)
//            } else {
//                #if os(iOS)
//                ContentView(presentingModal: $presentingModal)
//                    .fullScreenCover(isPresented: $presentingModal, content: SignInView.init)
//                    .animation(.none)
//                #else
//                ContentView(presentingModal: $presentingModal)
//                    .sheet(isPresented: $presentingModal, content: {
//                        SignInView()
//                    })
//                #endif
//            }
//        }.onChange(of: scenePhase, perform: { phase in
//            switch scenePhase {
//            case .active:
//                print("active")
//            case .background:
//                print("background")
//            case .inactive:
//                print("inactive")
//            default:
//                print("none")
//            }
//        })
    }
}

// MARK: Extension
//private extension MySecretaryApp {
//    func setupFirebase() {
////        FirebaseConfiguration.shared.setLoggerLevel(.min)
//        FirebaseApp.configure()
//    }
//}
