//
//  AccountViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol AccountViewModelInterface {
    var accounts: [Currency: Account] { get set }
}

class AccountViewModelImpl: AccountViewModelInterface {
    var accounts: [Currency: Account] = [:]
    
    var accountRouter: AccountRouterInterface?
    var accountInteractor: AccountInteractorInterface?
    // MARK: View properties
    var titleText: String = "Select an account to operate"
    var usdAccountText: String = "Not available"
    var arsAccountText: String = "Not available"
    var selectARSButtonText: String = "Select Account"
    var selectUSDButtonText: String = "Select Account"

    init() {
        SessionManager.shared.resetTempVarUser()
    }
    
    func getAccounts() {
        if let arsAccountResult = accountInteractor?.retrieveAccountByCurrency(currency: .ARS) {
            switch arsAccountResult {
            case .success(let account):
                self.accounts[Currency.ARS] = account
                setAccountsDescription()
            default:
                break
            }
        }
        
        if let usdAccountResult = accountInteractor?.retrieveAccountByCurrency(currency: .USD) {
            switch usdAccountResult {
            case .success(let account):
                self.accounts[Currency.USD] = account
                setAccountsDescription()

            default:
                break
            }
        }
    }
    /*
     In a real environment, this information is fetched async and we should have the labels as observable to update in the view reactively
     */
    func setAccountsDescription() {
        if let arsAmmount = self.accounts[Currency.ARS]?.getAmmount() {
            self.arsAccountText = "ARS Available: \(arsAmmount)"
        } else {
            self.arsAccountText = "Not available"
            self.selectARSButtonText = "Create ARS Account"
        }
        if let usdAmmount = self.accounts[Currency.USD]?.getAmmount() {
            self.usdAccountText = "USD Available: \(usdAmmount)"
        } else {
            self.usdAccountText = "Not available"
            self.selectUSDButtonText = "Create USD Account"
        }
    }
    
    /*
     Select an account to operate
     */
    func navigateToHome(currency: Currency) {
        switch currency {
        case .USD:
            guard self.accounts[Currency.USD] != nil else {
                //TODO: Handle account creation
                self.addNewAccount(
                    serviceResult: self.accountInteractor?.createAccount(currency: .USD),
                    currency: .USD
                )
                return
            }
            self.accountRouter?.navigateToHome(account: self.accounts[Currency.USD]!)
        case .ARS:
            guard self.accounts[Currency.ARS] != nil else {
                
                self.addNewAccount(
                    serviceResult: self.accountInteractor?.createAccount(currency: .ARS),
                    currency: .ARS
                )
                return
            }
            self.accountRouter?.navigateToHome(account: self.accounts[Currency.ARS]!)
        }
    }
    
    /*
     If the account selected isn't created yet, Create a new one.
     Improve using another view
     */
    private func addNewAccount(serviceResult: Result<Account, Error>?, currency: Currency) {
        switch serviceResult {
        case .success(let account):
            self.accounts[currency] = account
            navigateToHome(currency: .ARS)
        default:
            break
        }
    }
}
