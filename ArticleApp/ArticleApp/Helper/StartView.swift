//
//  StartView.swift
//  ArticleApp
//
//  Created by mac on 22/10/24.
//

import SwiftUI
import FirebaseAuth

struct StartView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        if authService.signedIn {
            DashboardView()
        } else {
            ContentView()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    @StateObject static var authService = AuthService()

    static var previews: some View {
        if authService.signedIn {
            DashboardView()
        } else {
            ContentView()
        }
    }
}
