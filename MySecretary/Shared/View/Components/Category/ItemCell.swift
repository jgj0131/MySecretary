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
        HStack {
            VStack {
                Image(systemName: "house.fill")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.black.opacity(0.15))
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 5)
                
                Spacer()
            }
                
            Text(contents)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                .foregroundColor(.black)
                .font(Font.custom("dovemayo", size: 18))
                .multilineTextAlignment(.trailing)
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(contents: "aiden\nasdad\nasdasd")
    }
}
