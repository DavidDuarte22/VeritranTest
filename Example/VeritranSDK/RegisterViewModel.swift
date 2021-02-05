//
//  RegisterViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol RegisterViewModelInterface {
    func registerNewUser(withIdentifier: String, withName: String)
}

class RegisterViewModelImpl: RegisterViewModelInterface {

    var registerRouter: RegisterRouterInterface?
    var registerInteractor: RegisterInteractorInterface?
    // MARK: View properties
    var titleText: String = "Register"
    var identifierText: String = "Identifier"
    var usernameText: String = "Name"
    var registerButtonText: String = "Register"
    
    func registerNewUser(withIdentifier: String, withName: String) {
        if (registerInteractor!.registerNewUser(withIdentifier: withIdentifier, withName: withName)) {
            registerRouter?.navigateToAccountSelector()
        } else {
            registerRouter?.showError(message: "Error creating user")
        }
    }
}
