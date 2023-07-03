//
//  EditItemView.swift
//  Wakelet_demo
//
//  Created by admin on 21/04/2023.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var collectionVM: CollectionViewModel
    var item: UIItem
    @State private var title = ""
    @State private var url = ""

    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var unsplashImage: String = ""
    @State private var showImagePicker = false
    @State private var showUnsplashPicker = false

    @Binding var showView: Bool

    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.easeOut(duration: 0.5)) {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(width: 10)
                        .shadow(radius: 4, y: 3)
                }
                Text("Add Link")
                    .padding(.trailing)
                Spacer()

                Button("Save") {
                    let jpegImg = inputImage?.jpegData(compressionQuality: 0.8)
                    collectionVM.editItem(item: item, title: title, url: url, uiImage: jpegImg, urlImage: unsplashImage)
                    dismiss()
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 10)
            .foregroundColor(.secondary)
            .font(.title2)

            Group {
                TextField("Edit Title:", text: $title)
                TextField("Edit URL:", text: $url)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 10)

            VStack {
                Menu {
                    Button {
                        showImagePicker = true
                        unsplashImage = ""
                    } label: {
                        Label {
                            Text("Pick form gallery")
                        } icon: {
                            Image(systemName: "photo.fill.on.rectangle.fill")
                        }
                    }
                    Button {
                        showUnsplashPicker = true
                        inputImage = nil
                    } label: {
                        Label {
                            Text("Pick form Unsplash")
                        } icon: {
                            Image(systemName: "photo.tv")
                        }
                    }
                } label: {
                    Label {
                        Text("Pick image")
                    } icon: {
                        Image(systemName: "photo.fill")
                    }
                }

                image?
                    .resizable()
                    .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                    .frame(maxWidth: 200)
                    .cornerRadius(10)
                    .shadow(radius: 10, y: 6)
                    .animation(.default, value: image)

                Spacer()
                    .frame(height: 50)
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .onChange(of: unsplashImage) { _ in loadImage() }

            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showUnsplashPicker) {
            UnsplashPicker(collectionVM: collectionVM, unsplashImage: $unsplashImage)
        }
    }

    func loadImage() {
        if !unsplashImage.isEmpty {
            if let url = URL(string: unsplashImage) {
                if let data = try? Data(contentsOf: url) {
                    image = Image(uiImage: UIImage(data: data)!)
                }
            }
        } else {
            guard let inputImage = inputImage else {
                return
            }
            image = Image(uiImage: inputImage)
        }
    }
}
