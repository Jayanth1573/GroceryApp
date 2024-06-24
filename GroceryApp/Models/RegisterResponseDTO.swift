//
//  RegisterResponseDTO.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 17/06/24.
//

import Foundation

struct RegisterResponseDTO: Codable {
    let error: Bool
    var reason: String? = nil
}
