//
//  DepositModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DepositModule {

    static func build() -> UIViewController {
        
        let viewModel = DepositViewModelImpl()
        let router = DepositRouterImpl()
        let interactor = DepositInteractorImpl(userRepository: SessionManager.shared.user!)
        let view = DepositViewImpl(viewModel: viewModel)
        
        viewModel.depositRouter = router
        viewModel.depositInteractor = interactor
        router.viewController = view
        
        return view
    }
}
