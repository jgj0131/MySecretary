//
//  DetailView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import AuthenticationServices

struct DetailView: View {
    var body: some View {
        List {
            ContentCell()
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
        }
    }
}

struct ContentCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("My Secretary")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
