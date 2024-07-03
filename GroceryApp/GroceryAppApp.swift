//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 12/06/24.
//

import SwiftUI

@main
struct GroceryAppApp: App {
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                RegisterScreen()
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
}
