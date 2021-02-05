//
//  RegisterModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class RegisterModule {

    static func build() -> UIViewController {
        
        let viewModel = RegisterViewModelImpl()
        let router = RegisterRouterImpl()
        let interactor = RegisterInteractorImpl()
        let view = RegisterViewImpl(viewModel: viewModel)
        
        viewModel.registerRouter = router
        viewModel.registerInteractor = interactor
        router.viewController = view
        
        return view
    }
}
