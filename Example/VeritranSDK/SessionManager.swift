//
//  SessionManager.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

class SessionManager {
    
    let veritranSDK: VeritranSDK
    
    var user: User?
    var activeAccount = Observable<Account?>(nil)
    static let shared = SessionManager()
    
    private init() {
        let userImpl = UserApiImpl(usersDb: [User(identifier: "francisco", name: "Pancho", accounts: [.USD: Account(type: .USD, ammount: 100.00)]),
                                             User(identifier: "matias", name: "Matias Fernandez", accounts: [.USD: Account(type: .USD, ammount: 100.00)])])
        veritranSDK = VeritranSDK(interface: userImpl)
    }
    
    func setUser(user: User) {
        self.user = user
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func addUser(user: User) -> String? {
        return veritranSDK.usersAPI.addUser(user: user)
    }
    
    func resetTempVarUser() {
        self.user = nil
        self.activeAccount.value = nil
    }
}
