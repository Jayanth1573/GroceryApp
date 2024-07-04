//
//  ErrorWrapper.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 04/07/24.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    let guidance: String
}
