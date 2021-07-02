//
//  EmailSignInButton.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/07/01.
//

import SwiftUI
import FirebaseAuth

struct EmailSignInButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("바로 로그인", action: signIn)
    }
        
    func signIn() {
        Auth.auth().signIn(withEmail: "aiden@loungelab.io", password: "Drill3737") { authResult, error in
            if (error != nil) {
                print(error?.localizedDescription as Any)
                return
            }
            presentationMode.wrappedValue.dismiss()
            print("signed in")
        }
    }
}

struct EmailSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignInButton()
    }
}
