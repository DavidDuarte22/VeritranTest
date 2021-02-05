//
//  HomeInteractor.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol HomeInteractorInterface: class {
    func getAccountBalance() -> Decimal?
    func getAccountCurrency() -> Currency?
}

class HomeInteractorImpl: HomeInteractorInterface {
    
    var currency: Currency?
    
    func getAccountBalance() -> Decimal? {
        return SessionManager.shared.activeAccount.value?.getAmmount()
    }
    
    func getAccountCurrency() -> Currency? {
        return SessionManager.shared.activeAccount.value?.type
    }
}
