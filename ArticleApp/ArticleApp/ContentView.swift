//
//  ContentView.swift
//  ArticleApp
//
//  Created by mac on 20/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Article App")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 42)
            Button(action: {}) {
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
                Spacer()                          // spacer to push text to the right
                Text("Forgotten Password?")
                    .fontWeight(.thin)            // make the font thinner
                    .foregroundColor(Color.blue)  // make the color blue
                    .underline()                  // underline the text
            }.padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
