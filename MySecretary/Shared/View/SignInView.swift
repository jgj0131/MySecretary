//
//  SignInView.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/06/16.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        #if os(iOS)
        VStack(alignment: .center, spacing: 30, content: {
            Spacer().frame(height: 50)
            Text("MySecretary")
                .foregroundColor(Color.init(.label))
                .frame(width:300, alignment: .center)
                .font(.title)
            Text("모든 일정을 관리해주는 My Secretary")
                .foregroundColor(Color.init(.label))
                .frame(width:300, alignment: .center)
                .font(.body)
            Spacer()
            AppleSignInButton()
            Spacer().frame(height: 50)
        }).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
        #else
        VStack(alignment: .center, spacing: 30, content: {
            Spacer().frame(height: 50)
            Text("MySecretary")
                .foregroundColor(Color.primary)//Color.init(.label))
                .frame(width:300, alignment: .center)
                .font(.title)
            Text("모든 일정을 관리해주는 MySecretary")
                .foregroundColor(Color.primary)//Color.init(.label))
                .frame(width:300, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                .font(.body)
            Spacer()
            AppleSignInButton()
            Spacer().frame(height: 50)
        })
        #endif
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        Group {
            SignInView().previewDevice("iPad Pro (12.9-inch) (4th generation)")
            SignInView().previewDevice("iPhone 12 Pro")
        }
        #else
        SignInView().previewDevice("Mac")
        #endif
    }
}
