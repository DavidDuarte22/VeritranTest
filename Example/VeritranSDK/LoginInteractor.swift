//
//  LoginInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol LoginInteractorInterface: class {
    func getAndSetUserById(identifier: String) -> Bool
}

class LoginInteractorImpl: LoginInteractorInterface {
    func getAndSetUserById(identifier: String) -> Bool {
        guard let user = SessionManager.shared.veritranSDK.usersAPI.getUserById(id: identifier) else {
            return false
        }
        SessionManager.shared.setUser(user: user)
        return true
    }
}
