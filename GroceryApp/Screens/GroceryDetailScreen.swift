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
    
    var body: some View {
        VStack {
            List(1...10, id:\.self) { index in
                Text("Grocery Item \(index)")
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
    }
}

struct GroceryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(), title: "beverages", colorCode: "#3498db"))
                .environmentObject(GroceryModel())
        }
        
    }
}
