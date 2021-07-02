//
//  AddListView.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/07/01.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var shouldShowActionSheet: Bool
    
    var body: some View {
        #if os(iOS)
        Button(action: {shouldShowActionSheet = false}, label: {
            Text("Close")
        })
        Text("추가")
        #else
        Text("추가")
        #endif
    }
}

struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView(shouldShowActionSheet: .constant(true))
    }
}
