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
        #if os(iOS)
        List {
            Section(header: Text("Thema")) {
                Text("🎨 테마 변경")
                Text("🔠 폰트 변경")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear(perform: {
            UITableView.appearance().isScrollEnabled = false
        })
        #else
        List {
            Section(header: Text("Thema")) {
                Text("🎨 테마 변경")
                Text("🔠 폰트 변경")
            }
        }
        #endif
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
