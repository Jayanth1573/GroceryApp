//
//  AppState.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 25/06/24.
//

import Foundation

enum Route: Hashable {
    case login
    case register
    case groceryCategoryList
}

class AppState: ObservableObject {
    
    @Published var routes: [Route] = []
    
}
