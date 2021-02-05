//
//  RegisterRouter.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol RegisterRouterInterface {
    func navigateToAccountSelector()
    func showError(message: String)
}

class RegisterRouterImpl: RegisterRouterInterface {
    
    weak var viewController: UIViewController?

    
    func navigateToAccountSelector() {
        viewController?.navigationController?.pushViewController(AccountModule.build(), animated: true)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
