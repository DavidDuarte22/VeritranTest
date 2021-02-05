//
//  RegisterInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol RegisterInteractorInterface {
    func registerNewUser(withIdentifier: String, withName: String) -> Bool
}

class RegisterInteractorImpl: RegisterInteractorInterface {
    func registerNewUser(withIdentifier: String, withName: String) -> Bool {
        let user = User(identifier: withIdentifier, name: withName)
        if let userID = SessionManager.shared.addUser(user: user) {
            return logUserAfterRegister(identifier: userID)
        }
        return false
    }
    
    
    private func logUserAfterRegister(identifier: String) -> Bool {
        guard let user = SessionManager.shared.veritranSDK.usersAPI.getUserById(id: identifier) else {
            return false
        }
        SessionManager.shared.setUser(user: user)
        return true
    }
}
