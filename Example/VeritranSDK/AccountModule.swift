//
//  AccountModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AccountModule {

    static func build() -> UIViewController {
        
        let viewModel = AccountViewModelImpl()
        let router = AccountRouterImpl()
        let interactor = AccountInteractorImpl()
        let view = AccountViewImpl(viewModel: viewModel)
        
        viewModel.accountRouter = router
        viewModel.accountInteractor = interactor
        router.viewController = view
        
        return view
    }
}
