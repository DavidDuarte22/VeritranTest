//
//  DepositRouter.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol DepositRouterInterface {
    func navigateToHome()
    func showError(message: String)
}

class DepositRouterImpl: DepositRouterInterface {
    
    weak var viewController: UIViewController?

    func navigateToHome() {
        //TODO: replace root vc
        viewController?.navigationController?.popViewController(animated: true)
        //viewController?.navigationController?.pushViewController(HomeModule.build(), animated: true)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
