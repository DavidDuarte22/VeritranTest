//
//  LoginModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LoginModule {

    static func build() -> UIViewController {
        
        let viewModel = LoginViewModelImpl()
        let router = LoginRouterImpl()
        let interactor = LoginInteractorImpl()
        let view = LoginViewImpl(viewModel: viewModel)
        
        viewModel.loginRouter = router
        viewModel.loginInteractor = interactor
        router.viewController = view
        
        return view
    }
}
