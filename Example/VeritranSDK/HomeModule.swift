//
//  HomeModule.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import VeritranSDK

class HomeModule {

    static func build() -> UIViewController {
        
        let viewModel = HomeViewModelImpl()
        let router = HomeRouterImpl()
        let interactor = HomeInteractorImpl()
        let view = HomeViewImpl(viewModel: viewModel)
        
        viewModel.homeRouter = router
        viewModel.homeInteractor = interactor
        router.viewController = view
        
        return view
    }
}
