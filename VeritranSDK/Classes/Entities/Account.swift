//
//  AccountModel.swift
//  VeritranSDK
//
//  Created by itsupport on 04/01/2021.
//

import Foundation

// TODO: Interface

public class Account {
    //MARK: Properties
    public typealias resultHandler = (Result<Decimal, Error>) -> Void
    
    public var identifier: String
    private var ammount: Decimal
    public let type: Currency
    
    public init(type: Currency, ammount: Decimal = 0) {
        self.identifier = ""
        self.ammount = ammount
        self.type = type
    }
    
    public init(identifier: String, type: Currency, ammount: Decimal = 0) {
        self.identifier = identifier
        self.ammount = ammount
        self.type = type
    }
    
    public func getAmmount() -> Decimal{
        return self.ammount
    }
    
    // Can an account have negative ammount?
    public func increaseAmmount(ammountTo deposit: Decimal, completion: @escaping resultHandler) {
        if let error = Validators.validateDepositAmmount(ammountToDeposit: deposit) {
            completion(.failure(error))
        } else {
            self.deposit(ammountTo: deposit)
            return completion(.success(self.ammount))
        }
    }
    
    public func withdrawAmmount(ammountTo withdraw: Decimal, completion: @escaping resultHandler) {
        if let error = Validators.validateWithdrawAmmount(ammount: self.ammount, ammountToWithdraw: withdraw) {
            completion(.failure(error))
        } else {
            self.withdraw(ammountTo: withdraw)
            return completion(.success(self.ammount))
        }
    }
}

// MARK: Private operations over account
private extension Account {
    func withdraw(ammountTo: Decimal){
        self.ammount -= ammountTo
    }
    func deposit(ammountTo: Decimal){
        self.ammount += ammountTo
    }
}

