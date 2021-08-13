//
//  AddListView.swift
//  MySecretary (iOS)
//
//  Created by jang gukjin on 2021/07/01.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var image: UIImage?
    @State private var date: Date?
//    @State private var isShowingImagePicker: Bool = false
    @State private var contentsInput: String = ""
    

    /// Callback after user selects to add contact with given name and image.
    let onAdd: ((String, UIImage?, Date?) -> Void)?
    /// Callback after user cancels.
    let onCancel: (() -> Void)?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
//                    contactImage.onTapGesture {
//                        self.isShowingImagePicker = true
//                    }
                    TextField("Full Name", text: $contentsInput)
                        .textContentType(.name)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Add Contact")
//            .sheet(isPresented: $isShowingImagePicker, onDismiss: {
//                isShowingImagePicker = false
//            }, content: {
//                ImagePicker(selectedImage: $image)
//            })
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { onCancel?() })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: { onAdd?(contentsInput, image, date) })
                        .disabled(contentsInput.isEmpty)
                }
            }
        }
    }

    var itemImage: some View {
        if let image = image {
            return AnyView(Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64, alignment: .center)
                            .clipped())
        } else {
            return AnyView(Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64, alignment: .center)
                            .foregroundColor(.gray))
        }
    }
}

struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView(onAdd: nil, onCancel: nil)
    }
}
