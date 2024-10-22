//
//  ContentView.swift
//  ArticleApp
//
//  Created by mac on 20/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices

struct ContentView: View {
    @State var username: String = ""
        @State var password: String = ""
        @State private var navigateToDashboard = false
        @State private var errorMessage: String?

        var body: some View {
            NavigationStack {
                VStack {
                    Text("Login Page")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.bottom, 42)
                    
                    VStack(spacing: 16.0) {
                        InputFieldView(data: $username, title: "Username")
                        InputFieldView(data: $password, title: "Password")
                    }
                    .padding(.bottom, 16)
                    
                    Button(action: {
                        signInWithEmail()
                    }) {
                        Text("Sign In with Email")
                            .fontWeight(.heavy)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                    }
                    .padding(.bottom, 16)
                    
                    Button(action: {
                        signInWithGoogle()
                    }) {
                        HStack {
                            Image(systemName: "g.circle.fill")
                            Text("Sign In with Google")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                    }
                    .padding(.bottom, 16)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    NavigationLink(destination: RegisterPage()) {
                        Text("Register !")
                            .fontWeight(.thin)
                            .foregroundColor(Color.blue)
                            .underline()
                    }
                    .padding(.top, 16)
                }
                .padding()
                .navigationDestination(isPresented: $navigateToDashboard) {
                    DashboardView()
                }
            }
        }
        
        // Email/Password login
        func signInWithEmail() {
            Auth.auth().signIn(withEmail: username, password: password) { result, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                navigateToDashboard = true
            }
        }
        
        // Google Sign-in
        func signInWithGoogle() {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.signIn(with: config, presenting: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()) { user, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        return
                    }
                    navigateToDashboard = true
                }
            }
        }
}

#Preview {
    ContentView()
}
