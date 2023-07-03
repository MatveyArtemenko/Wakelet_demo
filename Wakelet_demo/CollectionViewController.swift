//
//  CollectionViewController.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import SwiftUI

struct CollectionViewController: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var collectionVM = CollectionViewModel()
    @State private var itemViewMode = false
    @State private var addItemView = false
    @State private var showMenuView = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        HeaderView(collectionVM: collectionVM)
                        Text("\(collectionVM.uiCollection?.items.count ?? 1) \(collectionVM.uiCollection?.items.count == 1 ? "item" : "items")")
                            .foregroundColor(.secondary)
                        if !collectionVM.editCollectionMode {
                            ItemsView(collectionVM: collectionVM, itemsShowingMode: itemViewMode)
                                .disabled(showMenuView)
                        }
                    }
                    .onTapGesture {
                        if showMenuView {
                            withAnimation(.default) {
                                showMenuView = false
                            }
                        }
                    }
                }
                .blur(radius: showMenuView ? 5 : 0)
                .scaleEffect(showMenuView ? 1.1 : 1)
                .refreshable {
                    collectionVM.getCollections()
                }
                if showMenuView {
                    MenuView(collectionVM: collectionVM, deleteCollection: nil)
                        .transition(.move(edge: .leading))
                }

                if addItemView {
                    AddItemView(showView: $addItemView, collectionVM: collectionVM)
                        
                } else {
                    if !showMenuView, !collectionVM.editCollectionMode {
                        Button {
                            withAnimation(.easeOut(duration: 0.5).delay(0.1)) {
                                addItemView = true
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue)
                                .frame(width: 50)
                                .shadow(radius: 4, y: 3)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            .navigationTitle("Wakelet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring().speed(1.2)) {
                            itemViewMode.toggle()
                        }
                    } label: {
                        Image(systemName: itemViewMode
                            ? "rectangle.grid.2x2.fill"
                            : "rectangle.grid.1x2.fill"
                        )
                        .foregroundColor(.secondary)
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button {
                        withAnimation(.spring().speed(1.2)) {
                            collectionVM.editCollectionMode.toggle()
                        }
                    } label: {
                        Image(systemName: collectionVM.editCollectionMode
                            ? "checkmark.square"
                            : "square.and.pencil"
                        )
                        .foregroundColor(.secondary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                            showMenuView.toggle()
                        }
                    } label: {
                        Image(systemName: showMenuView
                            ? "xmark"
                            : "line.3.horizontal.circle"
                        )
                        .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct CollectionViewController_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewController()
    }
}
