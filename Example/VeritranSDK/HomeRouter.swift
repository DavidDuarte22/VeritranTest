//
//  HomeRouter.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol HomeRouterInterface {
    func navigateToDeposit()
    func navigateToWithdraw()
    func navigateToTransfer()
    func logout()
}

class HomeRouterImpl: HomeRouterInterface {
    
    weak var viewController: UIViewController?

    func navigateToDeposit() {
        viewController?.navigationController?.pushViewController(DepositModule.build(), animated: true)
    }
    
    func navigateToWithdraw() {
        viewController?.navigationController?.pushViewController(WithdrawModule.build(), animated: true)
    }
    
    func navigateToTransfer() {
        viewController?.navigationController?.pushViewController(TransferModule.build(), animated: true)
    }
    
    func logout() {
        let viewController = UINavigationController(rootViewController:LoginModule.build())
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
