//
//  TransferRouter.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol TransferRouterInterface {
    func showError(message: String)
    func showTransfer(transfer: Transfer)
}

class TransferRouterImpl: TransferRouterInterface {
    
    weak var viewController: UIViewController?

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func showTransfer(transfer: Transfer) {
        let alert = UIAlertController(title: "Transfer success",
                                      message: "From your \(transfer.fromAccount.type)'s Account. \n we withdraw \(transfer.ammount)\(transfer.fromAccount.type) \n for transfer to \(transfer.toUser.name) \(transfer.toAccount.type)'s Account."
                                      , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
            self.viewController?.navigationController?.popViewController(animated: true)
        }
        ))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
