//
//  AccountRouter.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import VeritranSDK

protocol AccountRouterInterface {
    func navigateToHome(account: Account)
}

class AccountRouterImpl: AccountRouterInterface {
    
    weak var viewController: UIViewController?
    
    func navigateToHome(account: Account) {
        let viewController = UINavigationController(rootViewController:HomeModule.build())
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
