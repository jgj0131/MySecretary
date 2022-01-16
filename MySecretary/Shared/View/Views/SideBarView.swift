//
//  SideBarView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

struct SideBarView: View {
//    @Binding var presentingModal: Bool
    @State private var selectedIndex = 0
    @State private var resetNavigationID = UUID()
    @State private var shouldShowActionSheet = false
    @State var isActive: Bool = false
    
    let sideBarImangeNames = ["calendar", "square.grid.3x3.topleft.fill", "link", "hand.thumbsup.fill"]
    let sideBarNames = ["Today", "All", "Share", "Done"]
    
    var sidebar: some View {
        VStack{
            ForEach(0..<4) { num in
                Spacer().frame(width: 10, height: 10, alignment: .center)
                Button(action: {
                    selectedIndex = num
                }, label: {
                    HStack {
                        Spacer().frame(width: 20, height: 10, alignment: .leading)
                        #if os(iOS)
                        Image(systemName: sideBarImangeNames[num])
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(selectedIndex == num ? Color(.label) : Color(.tertiaryLabel))

                        Text(sideBarNames[num])
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(selectedIndex == num ? Color(.label) : Color(.tertiaryLabel))
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                        #else
                        Image(systemName: sideBarImangeNames[num])
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(selectedIndex == num ? Color.primary : Color.secondary)

                        Text(sideBarNames[num])
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(selectedIndex == num ? Color.primary : Color.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                        #endif
                    }
                    Spacer()
                })
            }
            Spacer()
            Button(action: {
                shouldShowActionSheet.toggle()
            }, label: {
                #if os(iOS)
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
                    .frame(width: 250, height: 50, alignment: .center)
                #else
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.primary)
                    .frame(width: 250, height: 50, alignment: .center)
                #endif
            })
//                .sheet(isPresented: $shouldShowActionSheet, content: {
//                    AddListView(shouldShowActionSheet: $shouldShowActionSheet)
//                })
                .frame(width: 250, height: 50, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 2)
                )
            Spacer().frame(width: 20, height: 50, alignment: .center)
        }
    }
    
    var body: some View {
        #if os(iOS)
        NavigationView {
            sidebar
                .navigationBarTitle("My Secretary", displayMode: .large)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            selectedIndex = -1
                        }, label: {
                            Image(systemName: "gear")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == -1 ? Color(.label) : Color(.tertiaryLabel))
                        })
                    }
                })
            if selectedIndex == -1 {
                UserInfoView()
                    .navigationBarTitle("Setting", displayMode: .large)
            } else {
//                DetailView()
//                    .navigationBarTitle(sideBarNames[selectedIndex], displayMode: .large)
            }
            
        }
        #else
        NavigationView {
            sidebar
        }
        #endif
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        Group {
            SideBarView().previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
        #else
        SideBarView().previewDevice("Mac")
        #endif
    }
}
