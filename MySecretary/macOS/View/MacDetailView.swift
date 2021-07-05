//
//  MacDetailView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/12.
//

import SwiftUI

struct MacDetailView: View {
    var body: some View {
        List {
            MacContentCell()
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
            Text("222")
        }.navigationTitle("Todo") 
    }
}

struct MacContentCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("My Secretary")
    }
}

struct MacDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MacDetailView()
    }
}
