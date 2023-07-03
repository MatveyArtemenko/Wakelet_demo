//
//  CollectionViewModel.swift
//  Wakelet_demo
//
//  Created by admin on 17/04/2023.
//

import Foundation
import SwiftUI

@MainActor class CollectionViewModel: ObservableObject {
    @Published var uiCollections: [UICollection] = []
    @Published var uiCollection: UICollection?
    @Published var currentItem: UIItem?
    @Published var editCollectionMode = false
    var cursor: String = ""
    
    init() {
        getCollections()
        
//        if let collection = self.uiCollection {
//            self.editCollection(title: "1", description: "2", collection: collection)
//        }
    }

    func getCollections() {
        Task {
            do {
                let collectionsResponse = try await Network.shared.makeRequest(request: .getMyCollections(cursor: "")) as GetMyCollectionsResponse
                //                print(collectionsResponse)
                var allCollections: [UICollection] = []
                
                for collection in collectionsResponse.data.me.allCollections.edges {
                    var newCollection = collectionsResponse.toUICollection(collection: collection)
                    
                    let itemsRsponse = try await Network.shared.makeRequest(
                        request: .getItems(collectionId: collection.node.id,
                                           cursor: nil)) as ItemsResponse
                    
                    for item in itemsRsponse.result.data.content {
                        let data = Data()
                        let response = try await Network.shared.makeRequest(request: .getImageById(id: item.metadata.image)) as GetImageResponse
                        newCollection.items.append(UIItem(id: item.id, title: item.metadata.title, image: response.result.data.imageSizes.cover.first?.url ?? "", url: item.metadata.url, uiImage: data))
                    }
//                    uiCollections.append(newCollection)
                    allCollections.append(newCollection)
                    print("collections count: \(allCollections.count)")
                }
                uiCollections = allCollections
                self.uiCollection = uiCollections.first
                                
            } catch {
                print(error)
            }
        }
    }

    func removeCollection(_ colletion: UICollection) {
        Task {
            _ = try await Network.shared.makeRequest(request: .deleteCollection(collectionId: colletion.id)) as DeleteCollectionResponse
            print("deleting collection: \(colletion.id)" + " rest: \(uiCollections.count)")
            if let index = uiCollections.firstIndex(of: colletion) {
                uiCollections.remove(at: index)
            }
        }
    }
    
//    func getCollection() {
//        Task {
//            let response = try await Network.shared.makeRequest(request: .getCollection(collectionId: "Ry5OqkX-Vsfv6-OjAArHC")) as Collection
//            print(response)
//
//            self.uiCollection = response.toUICollection()
//            self.uiCollections.append(response.toUICollection())
//
//            let itemsRsponse = try await Network.shared.makeRequest(
//                request: .getItems(collectionId: "Ry5OqkX-Vsfv6-OjAArHC",
//                                   cursor: nil)) as ItemsResponse
//            self.cursor = itemsRsponse.result.data.cursor
//            var uiItems = [UIItem]()
//            for item in itemsRsponse.result.data.content {
//                let data = Data()
//                let response = try await Network.shared.makeRequest(request: .getImageById(id: item.metadata.image)) as GetImageResponse
//                uiItems.append(UIItem(id: item.id, title: item.metadata.title, image: response.result.data.imageSizes.cover.first?.url ?? "", url: item.metadata.url, uiImage: data))
//            }
//            self.uiCollection.items = uiItems
//        }
//    }
    
    func createCollection(title: String, description: String) {
        Task {
            do {
                let CreateCollectionResponse = try await Network.shared.makeRequest(request: .createCollection(parentId: "mpNc9G8Eruu6veNuZLnsi", title: title)) as CreateCollectionResponse
                uiCollections.append(
                    UICollection(
                        id: CreateCollectionResponse.data.createCollection.collection.id,
                        title: title,
                        description: description,
                        image: CreateCollectionResponse.data.createCollection.collection.coverImage.getImageByWidth.uri,
                        items: []
                    )
                )
                //                print(newCollection)
            } catch {
                print(error)
            }
        }
    }
    
    func editCollection(title: String, description: String, image: String, collection: UICollection) {
        Task {
            do {
                let editCollectionResponse = try await Network.shared.makeRequest(
                    request: .updateCollection(
                        title: title,
                        description: description,
                        id: collection.id
                    )
                ) as EditCollectionResponse
                    
                self.uiCollection?.title = title
                self.uiCollection?.description = description
                self.uiCollection?.image = image
                    
            } catch {
                print("error editing: \(error)")
            }
        }
    }
    
    func addItems(cursor: String) {
        Task {
            guard !cursor.isEmpty else {
                return
            }
            let newItems = try await Network.shared.makeRequest(
                request: .getItems(collectionId: "Ry5OqkX-Vsfv6-OjAArHC", cursor: nil)) as ItemsResponse
            self.cursor = newItems.result.data.cursor
            
            var uiItems = [UIItem]()
            for item in newItems.result.data.content {
                let data = Data()
                let response = try await Network.shared.makeRequest(request: .getImageById(id: item.metadata.image)) as GetImageResponse
                uiItems.append(UIItem(id: item.id, title: item.metadata.title, image: response.result.data.imageSizes.cover.first?.url ?? "", url: item.metadata.url, uiImage: data))
            }
            uiCollection?.items.append(contentsOf: uiItems)
        }
    }
    
    func removeItem(item: UIItem) {
        Task {
            // _ = try await Network.shared.makeRequest(request: .deleteItem(itemId: item.id)) as GetDeleteResponse
            if let index = uiCollections.first?.items.firstIndex(of: item) {
                uiCollection?.items.remove(at: index)
            }
        }
    }
    
    func addNewItem(item: UIItem) {
        if verifyUrl(urlString: item.url) {
            uiCollection?.items.append(item)
        }
    }
    
    func editItem(item: UIItem, title: String, url: String, uiImage: Data?, urlImage: String?) {
        if let index = uiCollection?.items.firstIndex(where: { $0.id == item.id }) {
            if !url.isEmpty {
                uiCollection?.items[index].url = url
            }
            if !title.isEmpty {
                uiCollection?.items[index].title = title
            }
            if let uiImage = uiImage {
                uiCollection?.items[index].uiImage = uiImage
                uiCollection?.items[index].image = ""
            } else {
                if let urlImage = urlImage {
                    uiCollection?.items[index].image = urlImage
                }
                uiCollection?.items[index].uiImage = Data()
            }
        }
    }
    
    func displayImage(item: UIItem) -> Image? {
        if let data = item.uiImage {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func loadNextPage(item: UIItem) {
        if item == uiCollection?.items.last {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.addItems(cursor: self.cursor)
            }
        }
    }
}
