//
//  LoginResponseDTO.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 23/06/24.
//

import Foundation

struct LoginResponseDTO: Codable {
    let error: Bool
    var reason: String? = nil
    var token: String? = nil
    var userId: UUID? = nil
}
