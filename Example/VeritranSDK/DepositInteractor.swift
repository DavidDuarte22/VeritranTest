//
//  DepositInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol DepositInteractorInterface: class {
    func depositMoney(ammount: Decimal, accountID: String) -> Result<Decimal, Error>
}

class DepositInteractorImpl: DepositInteractorInterface {
    
    let userRepository: User
    
    
    init(userRepository: User){
        self.userRepository = userRepository
    }
    
    func depositMoney(ammount: Decimal, accountID: String = "") -> Result<Decimal, Error>{
        /// Using a Shemaphore to convert async into sync and avoid another closoure as we're in a domain layer.
        /// Moreover, we should map the response into a domain object.
        let semaphore = DispatchSemaphore(value: 0)
        var response: Result<Decimal, Error>!
        
        userRepository.getAccountByID(identifier: accountID) { result in
            switch result {
            case .success(let account):
                account.increaseAmmount(ammountTo: ammount){ result in
                    switch result {
                    case .success(let newAmmount):
                        response = Result.success(newAmmount)
                        semaphore.signal()
                    case .failure(let error):
                        response = Result.failure(error)
                        semaphore.signal()
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
