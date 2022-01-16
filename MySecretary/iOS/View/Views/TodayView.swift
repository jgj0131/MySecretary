//
//  DetailView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import AuthenticationServices

struct TodayView: View {
    // MARK: Property
    private var items: FetchedResults<Item>
    private var deleteItem: (Optional<(IndexSet)>) -> Void
    
    // MARK: View
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer().frame(height: 20)
            ForEach(items) { item in
                ItemCell(contents: item.contents ?? "None")
                Spacer().frame(height: 10)
            }
            .onDelete(perform: deleteItem)
        
        }
    }
}

// MARK: Preview
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(items: [Item()])
//    }
//}
