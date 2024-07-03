//
//  AppState.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 25/06/24.
//

import Foundation
import GroceryAppSharedDTO

enum Route: Hashable {
    case login
    case register
    case groceryCategoryList
    case groceryCategoryDetail(GroceryCategoryResponseDTO)
}

class AppState: ObservableObject {
    
    @Published var routes: [Route] = []
    
}
