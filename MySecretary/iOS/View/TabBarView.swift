//
//  TabBarView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

struct TabBarView: View {
    // MARK: Property
    @Binding var presentingModal: Bool
    @State private var selectedIndex = 0
    @State private var resetNavigationID = UUID()
    @State private var shouldShowActionSheet = false
    @State var isActive: Bool = false
    
    let tabBarImangeNames = ["calendar", "square.grid.3x3.topleft.fill", "plus.app.fill", "link", "hand.thumbsup.fill"]
    let tabBarNames = ["Today", "All", "", "Share", "Done"]

    // MARK: View
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowActionSheet, content: {
                        AddListView(shouldShowActionSheet: $shouldShowActionSheet)
                    })
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                        DetailView()
                            .listStyle(InsetGroupedListStyle())
                            .navigationBarTitle("Today")
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(
                                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selectedIndex, rootIsActive: $isActive),
                                        isActive: self.$isActive
                                    ) {
                                        Image(systemName: "gear")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(Color(.secondaryLabel))
                                    }.isDetailLink(false)
                                }
                            })
                    }.id(self.resetNavigationID)
                case 1:
                    NavigationView {
                        DetailView()
                            .listStyle(InsetGroupedListStyle())
                            .navigationTitle("All")
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(
                                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selectedIndex, rootIsActive: $isActive),
                                        isActive: self.$isActive
                                    ) {
                                        Image(systemName: "gear")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(Color(.secondaryLabel))
                                    }.isDetailLink(false)
                                }
                            })
                    }.id(self.resetNavigationID)
                case 3:
                    NavigationView {
                        DetailView()
                            .listStyle(InsetGroupedListStyle())
                            .navigationTitle("Share")
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(
                                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selectedIndex, rootIsActive: $isActive),
                                        isActive: self.$isActive
                                    ) {
                                        Image(systemName: "gear")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(Color(.secondaryLabel))
                                    }.isDetailLink(false)
                                }
                            })
                    }.id(self.resetNavigationID)
                case 4:
                    NavigationView {
                        DetailView()
                            .listStyle(InsetGroupedListStyle())
                            .navigationTitle("Done")
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(
                                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selectedIndex, rootIsActive: $isActive),
                                        isActive: self.$isActive
                                    ) {
                                        Image(systemName: "gear")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(Color(.secondaryLabel))
                                    }.isDetailLink(false)
                                }
                            })
                    }.id(self.resetNavigationID)
                default:
                    Text("")
                }
            }
            Spacer()
            HStack{
                Spacer()
                ForEach(0..<5) { num in
                    if num == 2 {
                        Image(systemName: tabBarImangeNames[num])
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(Color(.label))
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        isActive = false
                                        shouldShowActionSheet.toggle()
                                    }
                            )
                    } else {
                        VStack {
                            Image(systemName: tabBarImangeNames[num])
                                .font(.system(size: 18, weight: .light))
                                .foregroundColor(selectedIndex == num ? Color(.label) : Color(.tertiaryLabel))
                            Text(tabBarNames[num])
                                .font(.system(size: 9, weight: .light))
                                .foregroundColor(selectedIndex == num ? Color(.label) : Color(.tertiaryLabel))
                        }
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    isActive = false
                                    selectedIndex = num
                                }
                        )
                    }
                    Spacer()
                }
            }
        }
    }
}

// MARK: Preview
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(presentingModal: .constant(true))
    }
}
