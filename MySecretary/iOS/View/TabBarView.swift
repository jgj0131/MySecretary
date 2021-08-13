//
//  TabBarView.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI

struct TabBarView: View {
    // MARK: Property
//    @Binding var presentingModal: Bool
    @State private var selectedIndex = 0
    @State private var resetNavigationID = UUID()
//    @State private var shouldShowActionSheet = false
    @State var isActive: Bool = false
    @State private var isShowingAddView = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
//    let tabBarImangeNames = ["calendar", "square.grid.3x3.topleft.fill", "plus.app.fill", "link", "hand.thumbsup.fill"]
    let tabBarImangeNames = ["calendar", "square.grid.3x3.topleft.fill", "plus.app.fill", "hands.clap", "gearshape"]
//    let tabBarNames = ["Today", "All", "", "Share", "Done"]
    let tabBarNames = ["TODAY", "ALL", "", "DONE", "SETTING"]

    // MARK: View
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                    .sheet(isPresented: $isShowingAddView, content: {
                        AddListView(onAdd: { contents, image, date in
                            isShowingAddView = false
                            addItem(contents: contents, image: image, date: date)
                        }, onCancel: { isShowingAddView = false })
                    })
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 10)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
                        .navigationBarTitle("Today")
                    }.id(self.resetNavigationID)
                case 1:
                    NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 10)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
                        .navigationBarTitle("All")
                    }.id(self.resetNavigationID)
                case 3:
                    NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 10)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
                        .navigationBarTitle("Done")
                    }.id(self.resetNavigationID)
                case 4:
                    NavigationView {
                        UserInfoView()
                            .listStyle(InsetGroupedListStyle())
                            .navigationTitle("Setting")
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
                                        isShowingAddView.toggle()
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
                .onDelete(perform: deleteItem)
            }
        }
    }
}

// MARK: Extension
extension TabBarView {
    // MARK: Custom Method
    /// Item을 추가하는 Method
    private func addItem(contents: String, image: UIImage?, date: Date?) {
        let newItem = Item(context: viewContext)
        newItem.contents = contents
        newItem.image = image
        newItem.date = date

        do {
            try viewContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }
    /// Item을 제거하는 Method
    private func deleteItem(offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}


// MARK: Preview
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
