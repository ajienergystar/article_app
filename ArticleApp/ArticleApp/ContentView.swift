//
//  ContentView.swift
//  ArticleApp
//
//  Created by mac on 20/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @State private var navigateToDashboard = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login Page")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.bottom, 42)
                VStack(spacing: 16.0) {
                    InputFieldView(data: $username, title: "Username")
                    InputFieldView(data: $password, title: "Passwords")
                }.padding(.bottom, 16)
                
                Button(action: {
                    navigateToDashboard = true
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
            .navigationDestination(isPresented: $navigateToDashboard) {
                DashboardView()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
