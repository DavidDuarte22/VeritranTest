//
//  WithdrawModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class WithdrawModule {

    static func build() -> UIViewController {
        
        let viewModel = WithdrawViewModelImpl()
        let router = WithdrawRouterImpl()
        let interactor = WithdrawInteractorImpl()
        let view = WithdrawViewImpl(viewModel: viewModel)
        
        viewModel.withdrawRouter = router
        viewModel.withdrawInteractor = interactor
        router.viewController = view
        
        return view
    }
}
