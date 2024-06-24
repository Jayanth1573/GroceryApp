//
//  Constants.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 17/06/24.
//

import Foundation

struct Constants {
    private static let baseUrlPath = "http://127.0.0.1:8080/api"
    
    struct Urls {
        static let register = URL(string: "\(baseUrlPath)/register")
        static let login = URL(string: "\(baseUrlPath)/login")
    }
}