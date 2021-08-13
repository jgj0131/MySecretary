//
//  DetailView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import AuthenticationServices

struct DetailView: View {
    // MARK: View
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer().frame(height:10)
            ContentCell()
            Spacer().frame(height:10)
            ContentCell()
            Spacer()
        }
    }
}

// MARK: Preview
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(items: [Item()])
//    }
//}
