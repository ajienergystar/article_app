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
                    InputFieldView(data: $password, title: "Passwords")
                }.padding(.bottom, 16)
                
                Button(action: {
                    authService.regularSignIn(email: email, password: password) { error in
                        if let e = error {
                            print(e.localizedDescription)
                        }
                    }
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
        }
    }
}

#Preview {
    ContentView()
}
