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
            #if os(iOS)
            NavigationView {
                DetailView()
                    .navigationBarTitle("Todo")
            }
            .tabItem {
                Label("Todo", systemImage: "clock.fill")
                    .accessibility(label: Text("Todo"))
            }
            .tag(Tab.todo)
            
            NavigationView {
                DetailView()
                    .navigationBarTitle("Doing")
            }
            .tabItem {
                Label("Doing", systemImage: "play.circle.fill")
                    .accessibility(label: Text("Doing"))
            }
            .tag(Tab.doing)
            
            NavigationView {
                DetailView()
                    .navigationBarTitle("Issue")
            }
            .tabItem {
                Label("Issue", systemImage: "exclamationmark.triangle.fill")
                    .accessibility(label: Text("Issue"))
            }
            .tag(Tab.doing)
            
            NavigationView {
                DetailView()
                    .navigationBarTitle("Done")
            }
            .tabItem {
                Label("Done", systemImage: "checkmark.circle.fill")
                    .accessibility(label: Text("Done"))
            }
            .tag(Tab.doing)
            #endif
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

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
