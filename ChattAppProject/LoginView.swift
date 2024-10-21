//
//  ContentView.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-15.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

struct LoginView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var image: UIImage?
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State  var shouldshowImagePicker = false
    
    init() {
        FirebaseApp.configure()
    }
   
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16) {
                    
                    Text("Welcome to Chat Link!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top, 32)
                    
                    //logo in the login view mode
                    if isLoginMode {
                    Image("Chat Link") //
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150) // A
                            .padding(.top, 32)
                        }
                    Spacer()
                    // for choosing which mode view you want to be.
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        
                        Button {
                            shouldshowImagePicker.toggle()
                            
                        } label: {Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                            
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    if isLoading {
                        ProgressView()
                    } else {
                        Button {
                            handleAction()
                        } label: {
                            HStack {
                                Spacer()
                                Text(isLoginMode ? "Log In" : "Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 14, weight: .semibold))
                                Spacer()
                            }.background(Color.blue)
                        }
                    }
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                    }
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
    }
    
    private func handleAction() {
        isLoading = true
        errorMessage = ""
        
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = "Failed to login: \(error.localizedDescription)"
                return
            }
            print("Successfully logged in user: \(result?.user.uid ?? "")")
        }
    }
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = "Failed to create account: \(error.localizedDescription)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
        }
    }
    

}

#Preview {
    LoginView()
}

