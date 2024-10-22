//
//  DashboardView.swift
//  ArticleApp
//
//  Created by mac on 21/10/24.
//

import SwiftUI


struct DashboardView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Welcome/nYour News")
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log out") {
                        print("Log out tapped!")
                        authService.regularSignOut { error in
                            
                            if let e = error {
                                print(e.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
