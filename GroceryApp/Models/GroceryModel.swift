//
//  GroceryModel.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 17/06/24.
//

import Foundation
import GroceryAppSharedDTO

@MainActor
class GroceryModel: ObservableObject {
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    let httpClient = HTTPClient()
    
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        let registerData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.Urls.register!, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
        
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        let loginPostData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.Urls.login!, method: .post(JSONEncoder().encode(loginPostData)), modelType: LoginResponseDTO.self)
        
        let loginResponseDTO = try await httpClient.load(resource)
        
        if !loginResponseDTO.error && loginResponseDTO.token != nil  && loginResponseDTO.userId != nil{
            // save the token in user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token!, forKey: "authToken")
            defaults.set(loginResponseDTO.userId!.uuidString, forKey: "userId")
        }
        return loginResponseDTO
    }
    
    func deleteGroceryCategory(groceryCategoryId: UUID) async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.deleteGroceryCategory(userdId: userId, groceryCategoryId: groceryCategoryId), method: .delete, modelType: GroceryCategoryResponseDTO.self)
        
        let deletedGroceryCategory = try await httpClient.load(resource)
        
        groceryCategories = groceryCategories.filter {$0.id != deletedGroceryCategory.id}
    }
    
    
    func populateGroceryCategories() async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.groceryCategoriesBy(userId: userId), modelType: [GroceryCategoryResponseDTO].self)
        
            groceryCategories = try await httpClient.load(resource)
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
       
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
//        create a link
        let resource = try Resource(url: Constants.saveGroceryCategoriesBy(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        //  /api/users/:userId/grocery-categories
        
        let groceryCategory = try await httpClient.load(resource)
        
        groceryCategories.append(groceryCategory)
    }
}
