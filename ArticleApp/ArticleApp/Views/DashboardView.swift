//
//  DashboardView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Good Morning\nUser Name")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    ArticleView()
                        .padding(.bottom, 30)
                    BlogView()
                        .padding(.bottom, 30)
                    ReportView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
}
