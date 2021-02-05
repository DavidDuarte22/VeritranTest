//
//  TransferInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol TransferInteractorInterface: class {
    func getAccountCurrency() -> Currency?
    func getUser(withIdentifier: String) -> User?
    func getUserAccount(forUser: User, currency: Currency) -> Result<Account, Error>
    func transferMoney(ammount: Decimal, toUser: User, toAccount: Account) -> Result<Transfer, Error>
}

class TransferInteractorImpl: TransferInteractorInterface {
    
    func getAccountCurrency() -> Currency? {
        return SessionManager.shared.activeAccount.value?.type
    }
    
    func getUser(withIdentifier: String) -> User? {
        guard let user = SessionManager.shared.veritranSDK.usersAPI.getUserById(id: withIdentifier) else {
            return nil
        }
        return user
    }
    
    func getUserAccount(forUser: User, currency: Currency) -> Result<Account, Error> {
        var response: Result<Account, Error>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        forUser.getAccountByCurrency(currency: currency) { result in
            switch result {
            case .success(let account):
                response = Result.success(account)
                semaphore.signal()
            case .failure(let error):
                response = Result.failure(error)
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        return response
    }
    
    func transferMoney(ammount: Decimal, toUser: User, toAccount: Account) -> Result<Transfer, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var response: Result<Transfer, Error>!

        var transfer: Transfer!
        
        SessionManager.shared.activeAccount.value?.withdrawAmmount(ammountTo: ammount){ result in
            
                switch result {
                case .success(_):
                    
                    toAccount.increaseAmmount(ammountTo: ammount){ result in
    
                            switch result {
                            case .success(_):
                                transfer = Transfer(
                                    fromUser: SessionManager.shared.user!,
                                    fromAccount: SessionManager.shared.activeAccount.value!,
                                    toUser: toUser, toAccount: toAccount, ammount: ammount)
                                
                                response = Result.success(transfer)
                                semaphore.signal()
                                
                            case .failure(_):
                                
                                // revert withdraw
                                SessionManager.shared.activeAccount.value?.increaseAmmount(ammountTo: ammount) { result in
                                    switch result {
                                    case .success(_):
                                        print("Revert success")
                                        // TODO: Add another custom error by default with a message to set.
                                        response = Result.failure(CustomError.accountNotFound)
                                        semaphore.signal()

                                    case .failure(let error):
                                        response = Result.failure(error)
                                        semaphore.signal()
                                    }
                                }
                                
                            }
                    }
                    
                case .failure(let error):
                    response = Result.failure(error)
                    semaphore.signal()
                }
        
        }
        semaphore.wait()
        return response
    }
}
