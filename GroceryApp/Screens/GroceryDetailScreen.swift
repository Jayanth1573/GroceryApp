//
//  GroceryDetailScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 02/07/24.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryDetailScreen: View {
    let groceryCategory: GroceryCategoryResponseDTO
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    private func populateGroceryItems() async {
        do {
            try await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteGroceryItem(groceryItemId: UUID) {
        
        Task {
            do {
                try await model.deleteGroceryItem(groceryItemId: groceryItemId ,groceryCategoryId: groceryCategory.id)
            } catch {
                print(error.localizedDescription)
            }
        
        }
    }
    
    var body: some View {
        VStack {
            if model.groceryItems.isEmpty {
                Text("No items found")
            } else {
                GroceryItemListView(groceryItems: model.groceryItems, onDelete: deleteGroceryItem)
            }
            
        }.navigationTitle(groceryCategory.title)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Grocery Item") {
                        isPresented = true
                    }
                }
            }.sheet(isPresented: $isPresented){
                NavigationStack {
                    AddGroceryItemScreen()
                }
            }
            .onAppear {
                model.groceryCategory = groceryCategory
            }
            .task {
                await populateGroceryItems()
            }
    }
}

struct GroceryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(uuidString: "2cf35b0d-8307-47d1-a880-0ee9e799a71e")!, title: "beverages", colorCode: "#3498db"))
                .environmentObject(GroceryModel())
        }
        
    }
}
