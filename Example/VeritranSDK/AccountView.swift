//
//  AccountView.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import VeritranSDK

class AccountViewImpl: UIViewController {
    let viewModel: AccountViewModelImpl
    
    required init(viewModel: AccountViewModelImpl) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.viewModel.getAccounts()
        self.setViewProperties()
        self.addSubviewsAndConstraints()
        
        self.selectUSDButton.addTarget(self, action: #selector(USDAccountTapped), for: .touchUpInside)
        self.selectARSButton.addTarget(self, action: #selector(ARSAccountTapped), for: .touchUpInside)


    }
    
    @objc private func USDAccountTapped(sender: UIButton) {
        self.viewModel.navigateToHome(currency: .USD)
    }
    
    @objc private func ARSAccountTapped(sender: UIButton) {
        self.viewModel.navigateToHome(currency: .ARS)
    }
    
    // MARK: View Properties
    var viewTitle: UILabel!
    var USDAccountStatus: UILabel!
    var selectUSDButton: UIButton!
    var ARSAccountStatus: UILabel!
    var selectARSButton: UIButton!
    
    func setViewProperties() {
        self.viewTitle = {
            let titleLabel = UILabel ()
            titleLabel.text = self.viewModel.titleText
            return titleLabel
        }()
        
        self.USDAccountStatus = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = self.viewModel.usdAccountText
            return label
        }()
        
        self.ARSAccountStatus = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = self.viewModel.arsAccountText
            return label
        }()
        
        self.selectUSDButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.selectUSDButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
        
        self.selectARSButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.selectARSButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
    }
    
    func addSubviewsAndConstraints() {
        [viewTitle, USDAccountStatus, selectUSDButton, ARSAccountStatus, selectARSButton]
            .forEach {
                view.addSubview($0!)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
        
        self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.USDAccountStatus.anchor(top: self.viewTitle.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        self.USDAccountStatus.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.selectUSDButton.anchor(top: self.USDAccountStatus.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
        self.ARSAccountStatus.anchor(top: self.selectUSDButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        self.ARSAccountStatus.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.selectARSButton.anchor(top: self.ARSAccountStatus.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
        
        
    }
    
}
