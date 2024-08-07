//
//  LoginScreen.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 22/06/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isInputValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)
            if !loginResponseDTO.error {
                print("logged in successfully.")
                
                // take the user to grocery category list screen
                appState.routes.append(.groceryCategoryList)
            } else {
                errorMessage = loginResponseDTO.reason ?? ""
                appState.errorWrapper = ErrorWrapper(error: GroceryError.login, guidance: loginResponseDTO.reason ?? "")
            }
        } catch {
//            errorMessage = error.localizedDescription
            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
        
    }
    
    var body: some View {
            VStack{
                
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
                Button("Login"){
                    Task {
                        await login()
                    }
                }
                .disabled(!isInputValid)
                .frame(width: 150,height: 50)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                HStack {
                    Text("Don't have an account ?")
                    Button("Register"){
                        appState.routes.append(.register)
                    }
                }
//                Text(errorMessage)
//                    .foregroundColor(.black)
                Spacer()
                
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarBackButtonHidden(true)
            .sheet(item: $appState.errorWrapper) { errorWrapper in
                ErrorView(errorWrapper: errorWrapper)
                    .presentationDetents([.fraction(0.25)])
            }
        
    }
}
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginScreen()
                .environmentObject(GroceryModel())
                .environmentObject(AppState())
        }
       
        
    }
}
