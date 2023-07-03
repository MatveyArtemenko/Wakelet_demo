//
//  ItemsView.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import SafariServices
import SwiftUI

struct ItemsView: View {
    @ObservedObject var collectionVM = CollectionViewModel()
    @State private var showWebPage = false
    var itemsShowingMode: Bool
    private let columns = [GridItem(.adaptive(minimum: 120))]
    var body: some View {
        if itemsShowingMode == true {
            LazyVStack {
                ForEach(collectionVM.uiCollection?.items ?? []) { item in
                    VStack {
                        SingleItemView(collectionVM: collectionVM, item: item)
                            .onDrag {
                                collectionVM.currentItem = item
                                return NSItemProvider(contentsOf: URL(string: item.url))!
                            }
                            .onDrop(of: [.url], delegate: DropViewDelegate(item: item, collectionVM: collectionVM))
                    }
                    .onTapGesture {
                        showWebPage = true
                    }

                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.regularMaterial)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                    .sheet(isPresented: $showWebPage) {
                        SafariView(urlString: item.url)
                    }
                }
            }
        } else {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(collectionVM.uiCollection?.items ?? []) { item in
                    VStack {
                        SingleItemView(collectionVM: collectionVM, item: item)
                            .onDrag {
                                collectionVM.currentItem = item
                                return NSItemProvider(contentsOf: URL(string: item.url))!
                            }
                            .onDrop(of: [.url], delegate: DropViewDelegate(item: item, collectionVM: collectionVM))
                    }
                    .onTapGesture {
                        showWebPage = true
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.regularMaterial)
                    }
                    .sheet(isPresented: $showWebPage) {
                        SafariView(urlString: item.url)
                    }
                }
            }
            .padding()
        }
    }
}

struct SingleItemView: View {
    @ObservedObject var collectionVM: CollectionViewModel
    var item: UIItem
    @State private var showEditView = false
    var body: some View {
        VStack {
            VStack {
                if !item.image.isEmpty {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)

                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    collectionVM.displayImage(item: item)?
                        .resizable()
                        .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.top, 5)
            .padding(.horizontal, 5)

            .onAppear {
                collectionVM.loadNextPage(item: item)
                print("The item \(collectionVM.uiCollection?.items.count ?? 0)")
            }

            Text(item.title)
                .font(.footnote)
                .truncationMode(.tail)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .frame(maxHeight: 70)
        }
        .contextMenu {
            Button {
                collectionVM.removeItem(item: item)
            } label: {
                Label {
                    Text("Remove item")
                } icon: {
                    Image(systemName: "trash")
                }
            }

            Button {
                withAnimation(.easeInOut(duration: 0.8)) {
                    showEditView = true
                }
            } label: {
                Label {
                    Text("Edit")
                } icon: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showEditView, content: {
            EditItemView(collectionVM: collectionVM, item: item, showView: $showEditView)
                .presentationDetents([.fraction(0.45)])
        })
    }
}
