//
//  DepositViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol DepositViewModelInterface {
    func makeDeposit(ammount: Decimal)
}

class DepositViewModelImpl: DepositViewModelInterface {
    var depositRouter: DepositRouterInterface?
    var depositInteractor: DepositInteractorInterface?
    
    // MARK: View properties
    var titleText: String = "Insert the ammount to deposit into your selected account"
    var ammountText: String = "Ammount to deposit: "
    var depositButtonText: String = "Make deposit"

    func makeDeposit(ammount: Decimal) {
        //TODO: fix id
        guard let depositResult = depositInteractor?.depositMoney(ammount: ammount, accountID: "") else { return }
        switch depositResult {
        case .success(let newAmmount):
            print(newAmmount)
            depositRouter?.navigateToHome()
        case .failure(_):
            depositRouter?.showError(message: "Error depositing the money. Try again and check your ammount")
        }
    }
}
