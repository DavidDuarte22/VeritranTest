//
//  User.swift
//  VeritranSDK
//
//  Created by itsupport on 04/01/2021.
//

import Foundation

public protocol UserInterface {
     func getAccountByCurrency(currency: Currency, completion: @escaping (Result<Account, Error>) -> Void)
     func addAccount(account: Account, completion: @escaping (Result<Account, Error>) -> Void)
    func getAccountByID(identifier: String, completion: @escaping (Result<Account, Error>) -> Void)
}

public class User {
    
    
    public typealias resultHandler<T> = (Result<T, Error>) -> Void
    
    //MARK: Properties
    private var accounts: [Currency :Account]
    
    public let name: String
    let identifier: String

    public init(identifier: String, name: String, accounts: [Currency: Account] = [:]){
        self.identifier = identifier
        self.name = name
        self.accounts = accounts
    }
    
    // MARK: Public operations
    
}

extension User: UserInterface {
    public func getAccountByID(identifier: String, completion: @escaping (Result<Account, Error>) -> Void) {
        guard let account = self.accounts.first(where: { $0.value.identifier == identifier }) else {
            return completion(.failure(CustomError.accountNotFound))
        }
        completion(.success(account.value))
    }
    
    public func getAccountByCurrency(currency: Currency, completion: @escaping resultHandler<Account>) {
        guard let account = self.accounts[currency] else {
            return completion(.failure(CustomError.accountNotFound))
        }
        //return account
        completion(.success(account))
    }
    
    public func addAccount(account: Account, completion: @escaping resultHandler<Account>) {
        if self.accounts[account.type] == nil {
            appendAccount(account: account)
            completion(.success(account))
        }
        // TODO: else ... return Existent account
    }
}

// MARK: Private operations over account
private extension User {
    func appendAccount(account: Account) {
        self.accounts[account.type] = account
    }
    //TODO: Delete an account
    //TODO: Have more than an account by currency. i.e. CA CC ??? 
}
