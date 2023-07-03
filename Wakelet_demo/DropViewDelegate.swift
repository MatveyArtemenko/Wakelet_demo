//
//  DropDelegate.swift
//  Wakelet_demo
//
//  Created by admin on 21/04/2023.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    var item: UIItem
    var collectionVM: CollectionViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        let fromIndex = collectionVM.uiCollection?.items.firstIndex { item -> Bool in
            item.id == collectionVM.currentItem?.id
        } ?? 0
        
        let toIndex = collectionVM.uiCollection?.items.firstIndex { item -> Bool in
            item.id == self.item.id
        } ?? 0
        
        if fromIndex != toIndex {
            withAnimation(.default) {
                let fromItem = collectionVM.uiCollection?.items[fromIndex]
                collectionVM.uiCollection?.items[fromIndex] = collectionVM.uiCollection!.items[toIndex]
                collectionVM.uiCollection?.items[toIndex] = fromItem!
            }
        }
    }
}
