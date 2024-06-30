//
//  AddGroceryCategoryScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 28/06/24.
//

import SwiftUI
import GroceryAppSharedDTO

struct AddGroceryCategoryScreen: View {
    @State private var title: String = ""
    @State private var colorCode: String = "#2ecc71"
    
    @EnvironmentObject private var model: GroceryModel
    @Environment(\.dismiss) private var dismiss
    
    private func saveGroceryCategory() async {
        
        let groceryCategoryRequestDTO = GroceryCategoryRequestDTO(title: title, colorCode: colorCode)
        
        do {
            try await model.saveGroceryCategory(groceryCategoryRequestDTO)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private var isInputValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        List {
            TextField("title", text: $title)
            ColorSelector(colorCode: $colorCode)
        }.navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await saveGroceryCategory()
                        }
                    }.disabled(!isInputValid)
                }
            }
    }
}

struct AddGroceryCategory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryCategoryScreen()
                .environmentObject(GroceryModel())
        }
    }
}
