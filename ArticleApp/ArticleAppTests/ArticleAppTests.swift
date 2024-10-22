//
//  ArticleAppTests.swift
//  ArticleAppTests
//
//  Created by mac on 20/10/24.
//

import XCTest
import SwiftUI
@testable import ArticleApp

class MockAuthService: AuthService {
    var signInCalled = false
    var shouldReturnError = false
    
    override func regularSignIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        signInCalled = true
        if shouldReturnError {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Login failed"]))
        } else {
            completion(nil)
        }
    }
}

final class ArticleAppTests: XCTestCase {

    // Login Test
    var sut: ContentView! // System Under Test
        var mockAuthService: MockAuthService!

        override func setUpWithError() throws {
            // Initialize the view and mock service
            mockAuthService = MockAuthService()
            sut = ContentView().environmentObject(mockAuthService) as? ContentView
        }

        override func tearDownWithError() throws {
            // Clean up
            sut = nil
            mockAuthService = nil
        }

        // Test empty email shows an alert
        func testLoginWithEmptyEmailShowsAlert() {
            sut.email = ""
            sut.password = "password123"
            
            sut.loginUser()
            
            XCTAssertEqual(sut.alertMessage, "Please enter your email.")
            XCTAssertTrue(sut.showAlert)
        }

        // Test empty password shows an alert
        func testLoginWithEmptyPasswordShowsAlert() {
            sut.email = "test@example.com"
            sut.password = ""
            
            sut.loginUser()
            
            XCTAssertEqual(sut.alertMessage, "Please enter your password.")
            XCTAssertTrue(sut.showAlert)
        }
        
        // Test invalid email shows an alert
        func testLoginWithInvalidEmailShowsAlert() {
            sut.email = "invalidemail"
            sut.password = "password123"
            
            sut.loginUser()
            
            XCTAssertEqual(sut.alertMessage, "Please enter a valid email address.")
            XCTAssertTrue(sut.showAlert)
        }
        
        // Test valid login calls AuthService
        func testValidLoginCallsAuthService() {
            sut.email = "test@example.com"
            sut.password = "password123"
            
            sut.loginUser()
            
            XCTAssertTrue(mockAuthService.signInCalled)
        }

        // Test login error from AuthService
        func testAuthServiceLoginError() {
            sut.email = "test@example.com"
            sut.password = "password123"
            
            mockAuthService.shouldReturnError = true
            
            sut.loginUser()
            
            XCTAssertTrue(mockAuthService.signInCalled)
            // You can add assertions to handle error responses as well
        }


}
