//
//  UserDefaults+Extensions.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 30/06/24.
//

import Foundation

extension UserDefaults {
    var userId: UUID? {
        get {
            guard let userIdString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: userIdString)
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
    
    
}

