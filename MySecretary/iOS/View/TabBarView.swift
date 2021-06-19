//
//  TabBarView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: Tab = .todo

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                #if os(iOS)
                DetailView()
                    .tabItem {
                        Label("Todo", systemImage: "clock.fill")
                            .accessibility(label: Text("Todo"))
                    }.tag(Tab.todo)
                
                DetailView()
                    .tabItem {
                        Label("Doing", systemImage: "play.circle.fill")
                            .accessibility(label: Text("Doing"))
                    }.tag(Tab.doing)
                
                DetailView()
                    .tabItem {
                        Label("Issue", systemImage: "exclamationmark.triangle.fill")
                            .accessibility(label: Text("Issue"))
                    }.tag(Tab.issue)
                
                DetailView()
                    .tabItem {
                        Label("Done", systemImage: "checkmark.circle.fill")
                            .accessibility(label: Text("Done"))
                    }.tag(Tab.done)
                #endif
            }
            .navigationBarTitle(selection.rawValue)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserInfoView()) {
                        Button(action: {}) {
                            Image(systemName: "person.crop.circle")
                        }
                    }
                }
            }
        }
    }
}

extension TabBarView {
    enum Tab: String {
        case todo = "todo"
        case doing = "doing"
        case issue = "issue"
        case done = "done"
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
