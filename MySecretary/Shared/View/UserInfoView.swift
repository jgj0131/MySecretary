//
//  UserInformation.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/06/19.
//

import SwiftUI
import FirebaseAuth

struct UserInfoView: View {
    var body: some View {
        List {
            Section(header: Text("Thema")/*, footer: Text("Footer1")*/ ) {
                Text("🎨 테마 변경")
                Text("🔠 폰트 변경")
            }
            Section(header: Text("Sign Out")) {
                Button(action: {
                        signOut()
                }, label: {
                    Text("🚪 로그 아웃")
                })
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear(perform: {
            UITableView.appearance().isScrollEnabled = false
        })
    }
}

extension UserInfoView {
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
