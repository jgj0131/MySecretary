//
//  TabBarView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

enum TabCategory: String {
    case todo = "Todo"
    case doing = "Doing"
    case issue = "Issue"
    case done = "Done"
}

struct TabBarView: View {
    // MARK: Property
    @Binding var presentingModal: Bool
    @State private var selection: TabCategory = .todo
    @State private var resetNavigationID = UUID()
    @State var isActive: Bool = false

    // MARK: View
    var body: some View {

        let selectable = Binding(
            get: { self.selection },
            set: {
                self.selection = $0
                self.resetNavigationID = UUID()
                self.isActive = false
            }
        )

        return TabView(selection: selectable) {
            self.todoTab()
                .tabItem {
                    Label("Todo", systemImage: "clock.fill")
                        .accessibility(label: Text("Todo"))
                }.tag(TabCategory.todo)
            
            self.doingTab()
                .tabItem {
                    Label("Doing", systemImage: "play.circle.fill")
                        .accessibility(label: Text("Doing"))
                }.tag(TabCategory.doing)
            self.issueTab()
                .tabItem {
                    Label("Issue", systemImage: "exclamationmark.triangle.fill")
                        .accessibility(label: Text("Issue"))
                }.tag(TabCategory.issue)
            self.doneTab()
                .tabItem {
                    Label("Done", systemImage: "checkmark.circle.fill")
                        .accessibility(label: Text("Done"))
                }.tag(TabCategory.done)
        }
    }

    // MARK: Custom Method
    private func todoTab() -> some View {
        NavigationView {
            DetailView()
            .navigationBarTitle(selection.rawValue)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selection, rootIsActive: $isActive),
                        isActive: self.$isActive
                    ) {
                        Image(systemName: "person.crop.circle")
                    }.isDetailLink(false)
                }
            }
        }.id(self.resetNavigationID)
    }

    private func doingTab() -> some View {
        NavigationView {
            DetailView()
            .navigationBarTitle(selection.rawValue)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selection, rootIsActive: $isActive),
                        isActive: self.$isActive
                    ) {
                        Image(systemName: "person.crop.circle")
                    }.isDetailLink(false)
                }
            }
        }.id(self.resetNavigationID)    }

    private func issueTab() -> some View {
        NavigationView {
            DetailView()
            .navigationBarTitle(selection.rawValue)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selection, rootIsActive: $isActive),
                        isActive: self.$isActive
                    ) {
                        Image(systemName: "person.crop.circle")
                    }.isDetailLink(false)
                }
            }
        }.id(self.resetNavigationID)
    }

    private func doneTab() -> some View {
        NavigationView {
            DetailView()
            .navigationBarTitle(selection.rawValue)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: UserInfoView(presentingModal: $presentingModal, selection: $selection, rootIsActive: $isActive),
                        isActive: self.$isActive
                    ) {
                        Image(systemName: "person.crop.circle")
                    }.isDetailLink(false)
                }
            }
        }.id(self.resetNavigationID)
    }
}

// MARK: Preview
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(presentingModal: .constant(true))
    }
}
