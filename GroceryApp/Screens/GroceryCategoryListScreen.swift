//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 01/07/24.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
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
                        
                        NavigationLink(value: Route.groceryCategoryDetail(groceryCategory)) {
                            HStack {
                                Circle()
                                    .fill(Color.fromHex(groceryCategory.colorCode))
                                    .frame(width: 25, height: 25)
                                Text(groceryCategory.title)
                            }
                        }
                       
                    }.onDelete(perform: deleteGroceryCategory)
                }
            }
        }
        .task {
            await fetchGroceryCategories()
        }
        .navigationTitle("Categories")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Logout") {
                    model.logout()
                    // take the user to login screen
                    appState.routes.append(.login)
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


struct GroceryCategoryListScreenContainer: View {
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            GroceryCategoryListScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .register:
                        RegisterScreen()
                    case .login:
                        LoginScreen()
                    case .groceryCategoryList:
                        Text("Grocery category list")
                    case .groceryCategoryDetail(let groceryCategory):
                        GroceryDetailScreen(groceryCategory: groceryCategory)
                    }
                }
            
        }
        .environmentObject(model)
        .environmentObject(appState)
    }
}

struct GroceryCategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack {
//            GroceryCategoryListScreen()
//                .environmentObject(GroceryModel())
//        }
        
        GroceryCategoryListScreenContainer()
        
    }
}
