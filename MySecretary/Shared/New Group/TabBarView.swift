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
        TabView(selection: $selection) {
            NavigationView {
                DetailView()
            }
            .tabItem {
                Label("Todo", systemImage: "clock.fill")
                    .accessibility(label: Text("Todo"))
            }
            .tag(Tab.todo)
            
            NavigationView {
                DetailView()
            }
            .tabItem {
                Label("Doing", systemImage: "play.circle.fill")
                    .accessibility(label: Text("Doing"))
            }
            .tag(Tab.doing)
            
            NavigationView {
                DetailView()
            }
            .tabItem {
                Label("Issue", systemImage: "exclamationmark.triangle.fill")
                    .accessibility(label: Text("Issue"))
            }
            .tag(Tab.doing)
            
            NavigationView {
                DetailView()
            }
            .tabItem {
                Label("Done", systemImage: "checkmark.circle.fill")
                    .accessibility(label: Text("Done"))
            }
            .tag(Tab.doing)
        }
    }
}

extension TabBarView {
    enum Tab {
        case todo
        case doing
        case issue
        case done
    }
}

struct ITabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
