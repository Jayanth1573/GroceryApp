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
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "authToken")
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                
                Group {
                    if token == nil {
                        RegisterScreen()
                    } else {
                        GroceryCategoryListScreen()
                    }
                    
                }
                
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .register:
                            RegisterScreen()
                        case .login:
                            LoginScreen()
                        case .groceryCategoryList:
                            GroceryCategoryListScreen()
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
