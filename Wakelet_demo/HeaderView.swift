//
//  HeaderView.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var collectionVM: CollectionViewModel
    @State private var editTitle = ""
    @State private var editDescription = ""
    
    @State private var unsplashImage: String = ""
    @State private var showUnsplashPicker = false

    var body: some View {
        VStack {
            if collectionVM.uiCollection?.image.isEmpty ?? false || collectionVM.editCollectionMode {
                Menu {
                    Button {
                        showUnsplashPicker = true
                    } label: {
                        Label {
                            Text("Pick form Unsplash")
                        } icon: {
                            Image(systemName: "photo.tv")
                        }
                    }
                } label: {
                    ZStack {
                        AsyncImage(url: URL(string: unsplashImage)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width * (3/4) - 20)
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

                            default:
                                Image(systemName: "photo")
                            }
                        }
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.regularMaterial
                                .opacity(unsplashImage.isEmpty ? 1 : 0.3)
                                .blendMode(.multiply))
                            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width * (3/4) - 20)
                            .padding()
                        Text("Change image")
                            .foregroundColor(.secondary)
                            .font(.title)
                            .bold()
                    }
                }
                .shadow(radius: 10, y: 6)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                
            } else {
                AsyncImage(url: URL(string: collectionVM.uiCollection?.image ?? "")) { image in
                    ZStack {
                        image
                            .resizable()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .scaleEffect(2)
                            .blur(radius: 18)
                            .opacity(0.8)
                            .offset(y: -60)
                            .hueRotation(Angle(degrees: 60))
                        
                        image
                            .resizable()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width * (3/4) - 20)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(radius: 10, y: 6)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                    }
                    .contextMenu {
                        Button {
                            withAnimation {
                                collectionVM.editCollectionMode = true
                            }
                        } label: {
                            Label("Edit collection", image: "square.and.pencil")
                        }
                    }
                    
                } placeholder: {
                    ProgressView()
                }
            }
            if collectionVM.uiCollection?.title.isEmpty ?? false || collectionVM.editCollectionMode {
                VStack {
                    TextField("Add title here...", text: $editTitle)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(10)
                    TextField("Add description here...", text: $editDescription)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(10)
                    
                    Button("Save") {
                        withAnimation {
                            guard let collection = collectionVM.uiCollection else {
                                return
                            }
                            collectionVM.editCollection(title: editTitle, description: editDescription, image: unsplashImage, collection: collection)
                            collectionVM.uiCollection?.image = unsplashImage
                            
                            editTitle = ""
                            editDescription = ""
                            unsplashImage = ""
                            collectionVM.editCollectionMode = false
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(15)
                }
                .padding(.horizontal)
                                
            } else {
                Text(collectionVM.uiCollection?.title ?? "")
                    .font(.largeTitle)
                Text(collectionVM.uiCollection?.description ?? "")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Divider()
            }
        }
        .sheet(isPresented: $showUnsplashPicker) {
            UnsplashPicker(collectionVM: collectionVM, unsplashImage: $unsplashImage)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(collectionVM: CollectionViewModel())
    }
}
