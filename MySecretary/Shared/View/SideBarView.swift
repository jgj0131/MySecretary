//
//  SideBarView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

struct SideBarView: View {
    enum NavigationItem {
        case todo
        case doing
        case issue
        case done
    }
        
    @State private var selection: Set<NavigationItem> = [.todo]
    
    var sidebar: some View {
        List(selection: $selection) {
            NavigationLink(destination: DetailView()) {
                Label("Todo", systemImage: "clock.fill")
            }
            .accessibility(label: Text("Menu"))
            .tag(NavigationItem.todo)
            
            NavigationLink(destination: DetailView()) {
                Label("Doing", systemImage: "play.circle.fill")
            }
            .accessibility(label: Text("Favorites"))
            .tag(NavigationItem.doing)
            
            NavigationLink(destination: DetailView()) {
                Label("Issue", systemImage: "exclamationmark.triangle.fill")
            }
            .accessibility(label: Text("Issue"))
            .tag(NavigationItem.issue)
            
            NavigationLink(destination: DetailView()) {
                Label("Done", systemImage: "checkmark.circle.fill")
            }
            .accessibility(label: Text("Done"))
            .tag(NavigationItem.done)
        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        #if os(iOS)
        NavigationView {
            sidebar
            .navigationBarTitle("My Secretary", displayMode: .large)
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
        SideBarView()
    }
}
