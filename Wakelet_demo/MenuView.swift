//
//  CollectionsView.swift
//  Wakelet_demo
//
//  Created by admin on 24/04/2023.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var collectionVM: CollectionViewModel
    var deleteCollection: UICollection?
    @State private var searcForCollection = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Button {
                    withAnimation {
                        collectionVM.createCollection(title: "Edit", description: "Testing description")
                    }
                } label: {
                    Label {
                        Text("Create collection")
                            .font(.callout)
                    } icon: {
                        Image(systemName: "plus.circle")
                    }
                }
                .foregroundColor(.white)
                .padding(.leading)
                Divider()
                VStack {
                    List {
                        ForEach(collectionVM.uiCollections) { collection in
                            CollectionUnit(collectionVM: collectionVM, collection: collection)
                                .listRowBackground(
                                    Rectangle()
                                        .fill(.clear)
                                        .padding(5)
                                )
                                .contextMenu {
                                    Button {
                                        collectionVM.removeCollection(collection)
                                        print("collections left: \(collectionVM.uiCollections.count)")
                                    } label: {
                                        Label("Delete collection", image: "trash")
                                    }
                                }
                        }
                    }
                    .padding(5)
                    .shadow(radius: 6, x: 3, y: 3)
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                    .background(Color.green.opacity(0.2).grayscale(1)
                        .ignoresSafeArea()
                    )
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.75)
        .background(
            ZStack {
                Color.gray.grayscale(0.3)
            }
            .ignoresSafeArea()
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CollectionUnit: View {
    @ObservedObject var collectionVM: CollectionViewModel
    var collection: UICollection
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    collectionVM.uiCollection = collection
                }
            } label: {
                HStack {
                    AsyncImage(url: URL(string: collection.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                            .frame(height: UIScreen.main.bounds.height * 0.12)
                            .frame(maxWidth: .infinity)

                    } placeholder: {
                        ProgressView()
                    }
                    .overlay {
                        Text(collection.title)
                            .foregroundColor(.white)
                            .fontWeight(.light)
                            .monospaced()
                            .padding(5)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
