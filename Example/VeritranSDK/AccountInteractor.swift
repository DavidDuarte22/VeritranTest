//
//  AccountInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol AccountInteractorInterface: class {
    func retrieveAccountByCurrency(currency: Currency) -> Result<Account, Error>
    func createAccount(currency: Currency) -> Result<Account, Error>
}

class AccountInteractorImpl: AccountInteractorInterface {
    func createAccount(currency: Currency) -> Result<Account, Error> {
        /// Using a Shemaphore to convert async into sync and avoid another closoure as we're in a domain layer.
        /// Moreover, we should map the response into a domain object.
        let account = Account(type: currency, ammount: 0)
        let semaphore = DispatchSemaphore(value: 0)
        var response: Result<Account, Error>!
        SessionManager.shared.user?.addAccount(account: account) { result in
            switch result {
            case .success(let account):
                response = self.retrieveAccountByCurrency(currency: account.type)
                semaphore.signal()
            case .failure(let error):
                response = Result.failure(error)
                semaphore.signal()
            }
        }
        semaphore.wait()
        return response
    }
    
    func retrieveAccountByCurrency(currency: Currency) -> Result<Account, Error> {
        /// Using a Shemaphore to convert async into sync and avoid another closoure as we're in a domain layer.
        /// Moreover, we should map the response into a domain object.
        let semaphore = DispatchSemaphore(value: 0)
        var response: Result<Account, Error>!
        SessionManager.shared.user?.getAccountByCurrency(currency: currency) { result in
            switch result {
            case .success(let account):
                response = Result.success(account)
                SessionManager.shared.activeAccount.value = account
                semaphore.signal()
            case .failure(let error):
                response = Result.failure(error)
                semaphore.signal()
            }
        }
        semaphore.wait()
        return response
    }
    
    
}
