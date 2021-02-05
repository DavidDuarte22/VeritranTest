//
//  LoginViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol LoginViewModelInterface {
    func signInUser(withIdentifier: String)
    func navigateToRegisterUser()
}

class LoginViewModelImpl: LoginViewModelInterface {
    
    var loginRouter: LoginRouterInterface?
    var loginInteractor: LoginInteractorInterface?
    // MARK: View properties
    var titleText: String = "Login"
    var loginButtonText: String = "Search user"
    var registerButtonText: String = "Or register a new user"
    
    func signInUser(withIdentifier: String) {
        if (loginInteractor?.getAndSetUserById(identifier: withIdentifier) == true) {
            loginRouter?.navigateToAccountSelector()
        } else {
            loginRouter?.showError(message: "User not found")
        }
    }
    
    func navigateToRegisterUser() {
        loginRouter?.navigateToRegister()
    }
}
