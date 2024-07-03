//
//  GroceryCategoryResponseDTO+Extensions.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 01/07/24.
//

import Foundation
import GroceryAppSharedDTO

extension GroceryCategoryResponseDTO: Identifiable, Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: GroceryCategoryResponseDTO, rhs: GroceryCategoryResponseDTO) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
