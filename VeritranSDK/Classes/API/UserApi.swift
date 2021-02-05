//
//  UserApiInterface.swift
//  VeritranSDK
//
//  Created by itsupport on 06/01/2021.
//

import Foundation

public protocol UserApiInterface {
    
    func getUserById(id: String) -> User?
    func getUsersByName(name: String) -> [User]?
    func addUser(user: User) -> String?
    var users: [User] { set get }
}

public class UserApiImpl: UserApiInterface {
    
    public var users: [User]
    
    public init(usersDb: [User]) {
        self.users = usersDb
    }
    
    public func getUserById(id: String) -> User? {
        guard let user = self.users.first(where: { $0.identifier == id }) else {
            return nil
        }
        return user
    }
    
    public func getUsersByName(name: String) -> [User]? {
        let users = self.users.filter({ $0.name == name })
        if users.isEmpty { return nil }
        return users
    }
    
    public func addUser(user: User) -> String? {
        if (Validators.validateUser(usersList: self.users, user: user) == nil) {
            self.users.append(user)
            return user.identifier
        } else {
            return nil
        }
    }
}
