//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 01/07/24.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
    @EnvironmentObject private var model: GroceryModel
    
    @State private var isPresented: Bool = false
    
    private func fetchGroceryCategories() async {
        do {
            try await model.populateGroceryCategories()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteGroceryCategory(at offsets: IndexSet) {
        offsets.forEach { index in
            let groceryCategory = model.groceryCategories[index]
            Task {
                do {
                    try await model.deleteGroceryCategory(groceryCategoryId: groceryCategory.id)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            
            if model.groceryCategories.isEmpty {
                Text("No grocery categories found.")
            } else {
                List {
                    ForEach(model.groceryCategories) { groceryCategory in
                        HStack {
                            Circle()
                                .fill(Color.fromHex(groceryCategory.colorCode))
                                .frame(width: 25, height: 25)
                            Text(groceryCategory.title)
                        }
                    }.onDelete(perform: deleteGroceryCategory)
                }
            }
        }
        .task {
            await fetchGroceryCategories()
        }
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Logout") {
                    
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isPresented) {
            NavigationStack {
                AddGroceryCategoryScreen()
            }
        }
    }
}

struct GroceryCategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryCategoryListScreen()
                .environmentObject(GroceryModel())
        }
        
    }
}
