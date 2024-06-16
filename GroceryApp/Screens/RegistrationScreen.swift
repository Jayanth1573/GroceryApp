//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 15/06/24.
//

import SwiftUI


struct RegisterScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    private var isInputValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    var body: some View {
        NavigationView{
            VStack {
                TextField("username", text: $username)
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
                    
                }
                .disabled(!isInputValid)
                .frame(width: 150,height: 50)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("Register")
            
        }
        
    }
    
}

#Preview {
    RegisterScreen()
}

