//
//  DetailView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

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
    var body: some View {
        HStack {
            Image(systemName: "tortoise.fill")
            Text("거북이")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
