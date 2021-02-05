//
//  WithdrawViewModel.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol WithdrawViewModelInterface {
    func makeWithdraw(ammount: Decimal)
}

class WithdrawViewModelImpl: WithdrawViewModelInterface {
    var withdrawRouter: WithdrawRouterInterface?
    var withdrawInteractor: WithdrawInteractorInterface?
    
    // MARK: View properties
    var titleText: String = "Insert the ammount to withdraw from your selected account"
    var ammountText: String = "Ammount to withdraw: "
    var depositButtonText: String = "Make withdraw"

    func makeWithdraw(ammount: Decimal) {
        guard let withdrawResult = withdrawInteractor?.withdrawMoney(ammount: ammount) else { return }
        switch withdrawResult {
        case .success(let newAmmount):
            print(newAmmount)
            withdrawRouter?.navigateToHome()
        case .failure(_):
            withdrawRouter?.showError(message: "Error withdrawing the money. Try again and check your ammount")
        }
    }
}
