//
//  ContentCell.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/08/09.
//

import SwiftUI

struct ContentCell: View {
    // MARK: View
    var body: some View {
        VStack {
            Spacer().frame(height: 13)
            
            HStack {
                Spacer().frame(width: 19)
                Text("나의 총 사용가능 포인트")
                    .font(Font.custom("NotoSansCJKkr-Medium", size: 13))
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            
            Spacer()
            
            HStack {
                Spacer().frame(width: 19)
                Text("₩ 0")
                    .foregroundColor(Color(.label))
                    .font(Font.custom("Nexa Bold", size: 30))
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("충전하기")
                    .foregroundColor(Color(.label))
                    .font(Font.custom("NotoSansCJKkr-Medium", size: 18))
                    .multilineTextAlignment(.trailing)
                Spacer().frame(width: 21)
                
            }
            
            Spacer().frame(height: 22)
        }
        .frame(height: 107, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(.systemBackground))
        .cornerRadius(7.0)
        .padding(EdgeInsets(top: 0, leading: 19, bottom: 0, trailing: 19))
        .shadow(color: .red, radius: 7, x: 1, y: 1)
    }
}

// MARK: Preview
struct ContentCell_Previews: PreviewProvider {
    static var previews: some View {
        ContentCell()
    }
}
