//
//  HomeViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol HomeViewModelInterface {
    func depositMoney()
    func withdrawMoney()
    func transferMoney()
}

class HomeViewModelImpl: HomeViewModelInterface {
    
    var homeRouter: HomeRouterInterface?
    var homeInteractor: HomeInteractorInterface?
    
    func getAccountStatus() {
        guard let interactor = self.homeInteractor?.getAccountCurrency(), let balance = self.homeInteractor?.getAccountBalance() else {
            return
        }
        self.titleText.value = "Select the operation. \(balance) \(interactor)"
        
    }
    
    // MARK: View properties
    var titleText: Observable<String> = Observable("Select the operation")
    var depositButtonText: String = "Deposit"
    var withdrawButtonText: String = "Withdraw"
    var transferButtonText: String = "Transfer"
    var logoutButtonText: String = "Logout"

    func depositMoney(){
        homeRouter?.navigateToDeposit()
    }
    
    func withdrawMoney() {
        homeRouter?.navigateToWithdraw()
    }
    
    func transferMoney(){
        homeRouter?.navigateToTransfer()
    }
    
    func logout() {
        homeRouter?.logout()
    }
}
