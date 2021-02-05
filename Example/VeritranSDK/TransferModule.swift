//
//  TransferModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TransferModule {

    static func build() -> UIViewController {
        
        let viewModel = TransferViewModelImpl()
        let router = TransferRouterImpl()
        let interactor = TransferInteractorImpl()
        let view = TransferViewImpl(viewModel: viewModel)
        
        viewModel.transferRouter = router
        viewModel.transferInteractor = interactor
        router.viewController = view
        
        return view
    }
}
