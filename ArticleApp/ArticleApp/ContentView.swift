//
//  ContentView.swift
//  ArticleApp
//
//  Created by mac on 20/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    @EnvironmentObject var authService: AuthService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login Page")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.bottom, 42)
                VStack(spacing: 16.0) {
                    InputFieldView(data: $email, title: "Email")
                    InputSecureFieldView(data: $password, title: "Passwords")
                }.padding(.bottom, 16)
                
                Button(action: {
                    loginUser()
                }) {
                    Text("Sign In")
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                }
                
                HStack {
                    Spacer()
                    NavigationLink(destination: RegisterPage()) {
                        Text("Register !")
                            .fontWeight(.thin)
                            .foregroundColor(Color.blue)
                            .underline()
                    }
                }.padding(.top, 16)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func loginUser() {
        guard !email.isEmpty else {
            alertMessage = "Please enter your email."
            showAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = "Please enter your password."
            showAlert = true
            return
        }
        
        guard isValidEmail(email) else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        authService.regularSignIn(email: email, password: password) { error in
            if let e = error {
                print(e.localizedDescription)
            }
        }
    }
    
    // Email validation function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    ContentView()
}
