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
    var body: some Scene {
        WindowGroup {
            LoginScreen()
                .environmentObject(model)
        }
    }
}
