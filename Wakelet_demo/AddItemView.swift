//
//  AddItemView.swift
//  Wakelet_demo
//
//  Created by admin on 20/04/2023.
//

import SwiftUI

struct AddItemView: View {
    @Binding var showView: Bool
    @ObservedObject var collectionVM: CollectionViewModel

    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showImagePicker = false

    @State private var urlString = ""
    @State private var title = ""
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Button {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showView = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(width: 15)
                        .shadow(radius: 4, y: 3)
                }
                Text("Add Link")
                    .padding(.trailing)
                Spacer()

                Button("Save") {
                    if let inputImage = inputImage {
                        let jpegImg = inputImage.jpegData(compressionQuality: 0.8)
                        let newItem = UIItem(id: UUID().uuidString, title: title, image: "", url: urlString, uiImage: jpegImg)
                        collectionVM.addNewItem(item: newItem)

                    } else {
                        let data = Data()
                        let newItem = UIItem(id: UUID().uuidString, title: title, image: "", url: urlString, uiImage: data)
                        collectionVM.addNewItem(item: newItem)
                    }
                    showView = false
                }
                .disabled(!collectionVM.verifyUrl(urlString: urlString))
            }
            .padding(.top)
            .foregroundColor(.secondary)
            .font(.title)
            Divider()

            Group {
                TextField("What is the title?", text: $title)

                TextField("Put url here", text: $urlString)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .background(.secondary)
            .cornerRadius(10)
            .padding(.bottom)

            VStack {
                Button {
                    showImagePicker = true
                } label: {
                    Label {
                        Text("Pick image")
                    } icon: {
                        Image(systemName: "photo.fill")
                    }
                }

                image?
                    .resizable()
                    .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(radius: 10, y: 6)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
            }
            .onChange(of: inputImage) { _ in loadImage() }
            Spacer()
                .frame(height: 130)
        }
        .padding(.horizontal)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .offset(y: 50)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
}
