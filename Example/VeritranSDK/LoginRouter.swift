//
//  LoginRouter.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol LoginRouterInterface: class {
    func navigateToRegister()
    func navigateToAccountSelector()
    func showError(message: String)
}

class LoginRouterImpl: LoginRouterInterface {
    
    
    weak var viewController: UIViewController?
    
    func navigateToRegister() {
       viewController?.navigationController?.pushViewController(RegisterModule.build(), animated: true)
    }
    
    func navigateToAccountSelector() {
        viewController?.navigationController?.pushViewController(AccountModule.build(), animated: true)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
