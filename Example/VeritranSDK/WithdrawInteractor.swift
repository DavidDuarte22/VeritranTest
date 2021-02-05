//
//  WithdrawInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol WithdrawInteractorInterface: class {
    func withdrawMoney(ammount: Decimal) -> Result<Decimal, Error>
}

class WithdrawInteractorImpl: WithdrawInteractorInterface {
    
    func withdrawMoney(ammount: Decimal) -> Result<Decimal, Error> {
        /// Using a Shemaphore to convert async into sync and avoid another closoure as we're in a domain layer.
        /// Moreover, we should map the response into a domain object.
        let semaphore = DispatchSemaphore(value: 0)
        var response: Result<Decimal, Error>!

        SessionManager.shared.activeAccount.value?.withdrawAmmount(ammountTo: ammount){ result in
            
                switch result {
                case .success(let newAmmount):
                    response = Result.success(newAmmount)
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
