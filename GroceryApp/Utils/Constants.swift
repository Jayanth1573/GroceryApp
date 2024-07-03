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
    
    static func saveGroceryCategoriesBy(userId: UUID) -> URL {
        return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories")!
    }
    
    static func groceryCategoriesBy(userId: UUID) -> URL {
        return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories")!
    }
    
    static func deleteGroceryCategory(userId: UUID, groceryCategoryId: UUID) -> URL {
        return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)")!
    }
    
    static func saveGroceryItem(userId: UUID, groceryCategoryId: UUID) -> URL {
        return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
    }
}
