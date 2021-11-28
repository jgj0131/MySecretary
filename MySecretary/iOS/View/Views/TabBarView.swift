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
    let tabBarImangeNames = ["app.badge", "scroll", "plus.circle.fill", "hands.clap", "gearshape"]

    // MARK: View
    var body: some View {
//        NavigationView {
            ZStack {
//                VStack {
//                    Color("navy").opacity(0.5).frame(height: 50)
//
//                    Spacer().frame(height: 0)
//
//                    Color.white
//                }.ignoresSafeArea(edges: .all)
                Color.white.ignoresSafeArea(edges: .all)
                
                VStack {
                    Spacer().frame(height: 100)
                    
                    switch selectedIndex {
                    case 0:
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 20)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
//                        .navigationBarTitle("Today")
                        .id(self.resetNavigationID)
                    case 1:
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 10)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
//                        .navigationBarTitle("All")
                        .id(self.resetNavigationID)
                    case 3:
                        Text("")
                            .frame(height: 0.01)
                        
                        Spacer().frame(height: 0.1)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 10)
                            ForEach(items) { item in
                                ItemCell(contents: item.contents ?? "None")
                                Spacer().frame(height: 10)
                            }
                            .onDelete(perform: deleteItem)
                        }
//                        .navigationBarTitle("Done")
                        .id(self.resetNavigationID)
                    case 4:
                        UserInfoView()
                            .listStyle(InsetGroupedListStyle())
//                            .navigationTitle("Setting")
                            .id(self.resetNavigationID)
                    default:
                        Text("")
                    }
                    
                    Spacer().frame(height: 0)
                    
                    tabbar()
                }
//                .background(Color("mint"))//.ignoresSafeArea(edges: .all)
                .background(Color.white)
                
//                VStack {
//                    Spacer()
//                    tabbar()
//                }
                
                VStack {
                    Text("Today")
                        .font(Font.custom("Nexa Bold", size: 20))
                        .padding(EdgeInsets(top: 100, leading: 20, bottom: 0, trailing: 0))
                        .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .topLeading)
                        .foregroundColor(.black)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("navy").opacity(0.5), Color("navy").opacity(0)]), startPoint: .top, endPoint: .bottom)
                                        .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center))

                    Spacer()
                }.ignoresSafeArea(edges: .top)
            }
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
                            .font(.system(size: 40/*35*/, weight: .light))
                            .imageScale(.large)
                            .foregroundColor(Color("navy"))
                            .aspectRatio(contentMode: .fit)
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        isActive = false
                                        isShowingAddView.toggle()
                                    }
                            )
                    } else {
                        VStack {
                            Image(systemName: tabBarImangeNames[num] + (selectedIndex == num ? ".fill" : "" ))
                                .font(.system(size: 23/*18*/, weight: .light))
                                .foregroundColor(Color("navy")/*selectedIndex == num ? Color.white : Color.gray*/)
                                .aspectRatio(contentMode: .fit)
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
//            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//            .background(Color("navy"))
//            .cornerRadius(20.0)
//            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            .background(Color.white)
            .shadow(color: Color("navy").opacity(0.15), radius: 0, x: 0, y: -0.5)
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
