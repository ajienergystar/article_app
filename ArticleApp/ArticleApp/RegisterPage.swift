//
//  RegisterPage.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct RegisterPage: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                // Username TextField
                InputFieldView(data: $username, title: "Username")
                    .padding(.horizontal)
                
                // Email TextField
                InputFieldView(data: $email, title: "Email")
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Phone Number TextField
                InputFieldView(data: $phoneNumber, title: "Phone Number")
                    .padding(.horizontal)
                    .keyboardType(.phonePad)
                
                // Address TextField
                InputFieldView(data: $address, title: "Address")
                    .padding(.horizontal)
                   
                // Password SecureField
                InputFieldView(data: $password, title: "Password")
                    .padding(.horizontal)
                
                // Confirm Password SecureField
                InputFieldView(data: $confirmPassword, title: "Confirm Password")
                    .padding(.horizontal)
                
                // Register Button
                Button(action: {
                    registerUser()
                }) {
                    Text("Register")
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Registration Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Registration validation and logic
    private func registerUser() {
        guard !username.isEmpty else {
            alertMessage = "Please enter your username."
            showAlert = true
            return
        }
        
        guard isValidEmail(email) else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        guard isValidPhoneNumber(phoneNumber) else {
            alertMessage = "Please enter a valid phone number."
            showAlert = true
            return
        }
        
        guard !address.isEmpty else {
            alertMessage = "Please enter your address."
            showAlert = true
            return
        }
        
        guard password.count >= 6 else {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            return
        }
        
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        // Perform registration logic here
        print("User Registered Successfully: \(username), \(email), \(phoneNumber), \(address)")
    }
    
    // Email validation function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Phone number validation (digits only, 10 to 15 digits allowed)
    private func isValidPhoneNumber(_ phone: String) -> Bool {
        let phoneRegEx = "^[0-9]{10,15}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phone)
    }
    
}

#Preview {
    RegisterPage()
}
