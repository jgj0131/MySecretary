//
//  MacDetailView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/12.
//

import SwiftUI

struct MacDetailView: View {
    // MARK: View
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            MacContentCell()
        }
        .navigationTitle("Todo") 
    }
}

// MARK: Preview
struct MacDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MacDetailView()
    }
}
