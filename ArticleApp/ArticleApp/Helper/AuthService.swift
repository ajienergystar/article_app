//
//  AuthService.swift
//  ArticleApp
//
//  Created by mac on 22/10/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth


class AuthService: ObservableObject {
    
    @Published var signedIn:Bool = false
    private var logoutTimer: Timer?
    
    init() {
        checkLoginStatus()
    }
    
    // MARK: - Password Account
    func regularCreateAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                
            } else {
                self.signedIn = true
                self.startLogoutTimer()
            }
        }
    }
    
    //MARK: - Traditional sign in
    // Traditional sign in with password and email
    func regularSignIn(email:String, password:String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if let e = error {
                completion(e)
            } else {
                self.signedIn = true
                self.startLogoutTimer()
                completion(nil)
            }
        }
    }
    
    // Regular password acount sign out.
    // Closure has whether sign out was successful or not
    func regularSignOut(completion: @escaping (Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            self.signedIn = false
            try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
          completion(signOutError)
        }
    }
    
    func logout() {
        regularSignOut { error in
            
            if let e = error {
                print(e.localizedDescription)
            }
        }
        self.signedIn = false
    }
    
    
    func checkLoginStatus() {
        if let lastLoginTime = UserDefaults.standard.object(forKey: "lastLoginTime") as? Date {
            let currentTime = Date()
            if currentTime.timeIntervalSince(lastLoginTime) > 600 { // 600 seconds = 10 minutes
                logout()
            } else {
                signedIn = true
                startLogoutTimer()
            }
        }
    }

    private func startLogoutTimer() {
        logoutTimer?.invalidate() // Invalidate any existing timer
        logoutTimer = Timer.scheduledTimer(withTimeInterval: 600, repeats: false) { [weak self] _ in // 10 minutes
            self?.logout()
        }
    }
}
