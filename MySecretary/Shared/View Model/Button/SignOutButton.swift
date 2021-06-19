//
//  SignOutButton.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/06/19.
//

import SwiftUI
import FirebaseAuth

struct SignOutButton: View {
    var body: some View {
        Button(action: {
                signOut()
        }, label: {
            Text("🚪 로그 아웃")
        })
    }
}

extension SignOutButton {
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

struct SignOutButton_Previews: PreviewProvider {
    static var previews: some View {
        SignOutButton()
    }
}
