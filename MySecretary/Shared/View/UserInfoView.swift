//
//  UserInformation.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/06/19.
//

import SwiftUI
import FirebaseAuth

struct UserInfoView: View {
    @Binding var presentingModal: Bool
    @Binding var selection: Int
    @Binding var rootIsActive: Bool
    
    var body: some View {
        List {
            Section(header: Text("Thema")/*, footer: Text("Footer1")*/ ) {
                Text("🎨 테마 변경")
                Text("🔠 폰트 변경")
            }
            Section(header: Text("Sign Out")) {
                SignOutButton(presentingModal: $presentingModal, selection: self.$selection, shouldPopToRootView: self.$rootIsActive)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear(perform: {
            UITableView.appearance().isScrollEnabled = false
        })
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(presentingModal: .constant(true), selection: .constant(0), rootIsActive: .constant(true))
    }
}
