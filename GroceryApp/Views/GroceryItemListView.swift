//
//  GroceryItemListView.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 03/07/24.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryItemListView: View {
    let groceryItems: [GroceryItemResponseDTO]
    let onDelete: (UUID) -> Void
    
    private func deleteGroceryItem(at offsets: IndexSet){
        offsets.forEach { index in
            let groceryItem = groceryItems[index]
            onDelete(groceryItem.id)
        }
    }
    var body: some View {
        List {
            ForEach(groceryItems) { groceryItem in
                Text(groceryItem.title)
            }.onDelete(perform: deleteGroceryItem)
        }
    }
}

struct GroceryItemListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemListView(groceryItems: [], onDelete: { _ in })
    }
}

