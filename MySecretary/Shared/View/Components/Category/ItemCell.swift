//
//  ItemCell.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/08/13.
//

import SwiftUI

struct ItemCell: View {
    var contents: String
    
    var body: some View {
        VStack {
            Text(contents)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                .foregroundColor(.black)
                .font(Font.custom("dovemayo", size: 18))
                .multilineTextAlignment(.trailing)
        }
        .background(Color("navy").opacity(0.25))//Color(.systemBackground))
        .cornerRadius(10.0)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//        .shadow(color: .blue, radius: 7, x: 1, y: 1)
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(contents: "aiden")
    }
}
