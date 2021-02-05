//
//  TransferViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

protocol TransferViewModelInterface {
    func lookForUser(withIdentifier: String)
    func makeTransfer(ammount: Decimal)
}

class TransferViewModelImpl: TransferViewModelInterface {
    var transferRouter: TransferRouterInterface?
    var transferInteractor: TransferInteractorInterface?
    
    // MARK: View properties
    var titleText: String = "Transfer to "
    var searchUserText: String = "Insert ID: "
    var searchForUserButtonText: String = "Search user"
    
    var ammountText: String = "Ammount: "
    var transferButtonText: String = "Transfer money"
    
    var userAccountToTransfer = Observable<Account?>(nil)
    var userSearched = Observable<User?>(nil)
    
    func lookForUser(withIdentifier: String){
        guard let userSearched = self.transferInteractor?.getUser(withIdentifier: withIdentifier) else { return }
        self.titleText = "Transfer to \(userSearched.name)"
        self.userSearched.value = userSearched
        
        guard let userCurrency = self.transferInteractor?.getAccountCurrency() else { return }

        let result = transferInteractor?.getUserAccount(forUser: userSearched, currency: userCurrency)
        switch result {
        case .success(let account):
            userAccountToTransfer.value = account
        case .failure(let error):
            self.transferRouter?.showError(message: error.localizedDescription)
        case .none:
            break
        }
    }

    func makeTransfer(ammount: Decimal) {
        guard userSearched.value != nil, userAccountToTransfer.value != nil else { return }
        guard let transferResult = transferInteractor?.transferMoney(ammount: ammount, toUser: userSearched.value!, toAccount: userAccountToTransfer.value!) else { return }
        switch transferResult {
        case .success(let transfer):
            print(transfer)
            transferRouter?.showTransfer(transfer: transfer)
        case .failure(let error):
            transferRouter?.showError(message: error.localizedDescription)
        }
    }
}
