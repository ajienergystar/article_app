//
//  DashboardView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Good Morning\nUser Name")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                    ArticleView(viewModel: AppDependencyInjector.articleInject())
                        .padding(.bottom, 30)
                    BlogView(viewModel: AppDependencyInjector.blogInject())
                        .padding(.bottom, 30)
                    ReportView(viewModel: AppDependencyInjector.reportInject())
                }
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
}
