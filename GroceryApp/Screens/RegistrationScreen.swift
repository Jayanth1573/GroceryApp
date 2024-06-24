//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 15/06/24.
//

import SwiftUI


struct RegisterScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    private var isInputValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func register() async {
        do {
            let registerResponseDTO = try await model.register(username: username, password: password)
            if !registerResponseDTO.error {
                print("Registered successfully")
                // take the user to the login screen
            } else {
                errorMessage = registerResponseDTO.reason ?? ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    var body: some View {
        NavigationStack{
            VStack {
                TextField("username", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .frame(width: 350,height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                SecureField("password", text: $password)
                    .padding()
                    .frame(width: 350,height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Button("Register"){
                    Task {
                        await register()
                    }
                }
                .disabled(!isInputValid)
                .frame(width: 150,height: 50)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                Text(errorMessage)
                    .foregroundColor(.black)
                Spacer()
                
                
            }
            .padding()
            .navigationTitle("Registration")
            
        }
        
    }
    
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
            .environmentObject(GroceryModel())
    }
}

