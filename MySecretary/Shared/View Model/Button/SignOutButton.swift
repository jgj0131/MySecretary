//
//  SignOutButton.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/06/19.
//

import SwiftUI
import FirebaseAuth

struct SignOutButton: View {
    // MARK: Property
    @Binding var presentingModal: Bool
    @Binding var selection: TabCategory
    @Binding var shouldPopToRootView: Bool
    
    // MARK: View
    var body: some View {
        Button("🚪 로그 아웃", action: signOut)
    }
    
    // MARK: Custom Method
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            if self.selection == .todo {
                self.shouldPopToRootView = false
            } else {
                self.shouldPopToRootView = false
                self.selection = .todo
            }
            presentingModal = true
            #if os(iOS)
//            TabBarView()
//                .fullScreenCover(isPresented: $presentingModal, content: SignInView.init)
//                .animation(.none)
            #else
//            ContentView()
//                .sheet(isPresented: $presentingModal, content: {
//                    SignInView()
//                })
            #endif
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

// MARK: Preview
struct SignOutButton_Previews: PreviewProvider {
    static var previews: some View {
        SignOutButton(presentingModal: .constant(true), selection: .constant(.todo), shouldPopToRootView: .constant(true))
    }
}
