//
//  UnsplashPicker.swift
//  Wakelet_demo
//
//  Created by admin on 27/04/2023.
//

import SwiftUI

struct UnsplashPicker: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var collectionVM: CollectionViewModel
    @ObservedObject var searchVC = SearchObjectController.shared
    @State private var searchText = ""
    private let columns = [GridItem(.adaptive(minimum: 80))]
    @Binding var unsplashImage: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("'food', 'animals', 'buildings'", text: $searchText)
                        .padding(5)
                        .padding(.horizontal)
                        .background(.regularMaterial)
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    Button("Search") {
                        searchVC.searchText = self.searchText
                        searchVC.search()
                    }
                }
                .padding()
                Spacer()
                ScrollView {
                    LazyVStack {
                        LazyVGrid(columns: columns) {
                            ForEach(searchVC.results, id: \.id) { item in
                                Button {
                                    unsplashImage = item.urls.small
                                    dismiss()
                                } label: {
                                    AsyncImage(url: URL(string: item.urls.regular)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        default:
                                            Image(systemName: "photo")
                                        }
                                    }

//                                .padding()
                                }
                                .frame(maxWidth: .infinity)
                                .aspectRatio(CGSize(width: 4, height: 3), contentMode: .fit)
                                .clipped()
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}
