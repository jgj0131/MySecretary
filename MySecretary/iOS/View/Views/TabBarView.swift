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
    @State private var currentDate: Date = Date()
    @State private var selectedIndex = 0
    @State private var resetNavigationID = UUID()
//    @State private var shouldShowActionSheet = false
    @State var isActive: Bool = false
    @State private var isShowingAddView = false
    @State private var title = "Today"
    @State private var color: Color = Color(UIColor.label)//("navy")
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
//    let tabBarImangeNames = ["calendar", "square.grid.3x3.topleft.fill", "plus.app.fill", "link", "hand.thumbsup.fill"]
    let tabBarImangeNames = ["app.badge.fill", "calendar", "plus.circle.fill", "hands.clap.fill", "gearshape.fill"]

    // MARK: View
    var body: some View {
//        NavigationView {
            ZStack {
                Color(UIColor.systemBackground).ignoresSafeArea(edges: .all)
                
                VStack {
                    Spacer().frame(height: 20)
                    
                    switch selectedIndex {
                    case 0:
                        VStack(spacing: 0) {
                            Color(UIColor.systemBackground).frame(height: UIDevice.current.hasNotch ? 50 : 10)
                            
                            Text(title)
                                .font(Font.custom("Nexa Bold", size: 30))
                                .foregroundColor(Color.pink)
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                Spacer().frame(height: 20)
                                ForEach(items) { item in
                                    ItemCell(contents: item.contents ?? "None")
                                    Spacer().frame(height: 10)
                                }
                                .onDelete(perform: deleteItem)
                            }
                        }
                        .onAppear(perform: {
                            title = "Today"
                        })
                        .id(self.resetNavigationID)
                    case 1:
                        CalendarView(currentDate: $currentDate)
                            .id(self.resetNavigationID)
                    case 3:
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 20)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
                        .onAppear(perform: {
                            title = "Done"
                        })
                        .id(self.resetNavigationID)
                    case 4:
                        UserInfoView()
                            .listStyle(InsetGroupedListStyle())
                            .onAppear(perform: {
                                title = "Setting"
                            })
                            .id(self.resetNavigationID)
                    default:
                        Text("")
                    }
                    
                    Spacer().frame(height: 0)
                    
                    tabbar()
                }
            }
            .ignoresSafeArea(edges: [.top, .bottom])
            .sheet(isPresented: $isShowingAddView, content: {
                AddListView(onAdd: { contents, image, date in
                    isShowingAddView = false
                    addItem(contents: contents, image: image, date: date)
                }, onCancel: { isShowingAddView = false })
            })
//        }
    }
}

// MARK: Extension
extension TabBarView {
    // MARK: Custom Method
    /// Tab List
    private func tabbar() -> some View {
        var view: some View {
            HStack{
                Spacer()
                ForEach(0..<5) { num in
                    if num == 2 {
                        Image(systemName: tabBarImangeNames[num])
                            .font(.system(size: 35, weight: .light))
                            .imageScale(.large)
                            .foregroundColor(Color.pink)
                            .background(Color(UIColor.systemBackground))
                            .frame(width: 43, height: 43, alignment: .center)
                            .cornerRadius(21.5)
                            .aspectRatio(contentMode: .fit)
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        isActive = false
                                        isShowingAddView.toggle()
                                    }
                            )
                            .shadow(color: .primary.opacity(0.3), radius: 2, x: 2, y: 2)
                            .shadow(color: .gray.opacity(0.12), radius: 2, x: -1, y: -1)
                            
                    } else {
                        ZStack {
                            Image(systemName: tabBarImangeNames[num])
                                .font(.system(size: 23, weight: .light))
                                .foregroundColor(.gray.opacity(0.1))
                                .aspectRatio(contentMode: .fit)
                            
                            Image(systemName: tabBarImangeNames[num])
                                .font(.system(size: 23, weight: .light))
                                .foregroundColor(Color.pink.opacity(selectedIndex == num ? 1 : 0.25))
                                .aspectRatio(contentMode: .fit)
                                .gesture(
                                    TapGesture()
                                        .onEnded { _ in
                                            isActive = false
                                            selectedIndex = num
                                        }
                                )
                        }
                        
                    }
                    
                    Spacer()
                }
                .onDelete(perform: deleteItem)
            }
            .padding(.top, 5)
            .padding(.bottom, UIDevice.current.hasNotch ? 25 : 5)
            .background(Color(UIColor.systemBackground))
            .shadow(color: color.opacity(selectedIndex == 1 ? 0 : 0.15), radius: 0, x: 0, y: -0.5)
        }
        return view
    }
    
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
