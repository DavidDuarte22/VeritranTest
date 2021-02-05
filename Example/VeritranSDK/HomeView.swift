//
//  HomeView.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewImpl: UIViewController {
    let viewModel: HomeViewModelImpl
    
    required init(viewModel: HomeViewModelImpl) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.setViewProperties()
        self.addSubviewsAndConstraints()
        
        self.selectDepositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
        self.selectWithdrawButton.addTarget(self, action: #selector(withdrawTapped), for: .touchUpInside)
        self.selectTransferButton.addTarget(self, action: #selector(transferTapped), for: .touchUpInside)
        self.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)


        self.viewModel.titleText.bind { _ in
            self.viewTitle.text = self.viewModel.titleText.value
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getAccountStatus()
    }
    
    //MARK: Operations
    @objc private func depositTapped(sender: UIButton) {
        self.viewModel.depositMoney()
    }
    
    @objc private func withdrawTapped(sender: UIButton) {
        self.viewModel.withdrawMoney()
    }
    
    @objc private func transferTapped(sender: UIButton) {
        self.viewModel.transferMoney()
    }
    
    @objc private func logoutTapped(sender: UIButton) {
        self.viewModel.logout()
    }
    
    // MARK: View Properties
    var viewTitle: UILabel!
    var selectDepositButton: UIButton!
    var selectWithdrawButton: UIButton!
    var selectTransferButton: UIButton!
    
    var logoutButton: UIButton!
    
    func setViewProperties() {
        self.viewTitle = {
            let titleLabel = UILabel ()
            titleLabel.numberOfLines = 2
            titleLabel.text = self.viewModel.titleText.value
            return titleLabel
        }()
        
        
        self.selectDepositButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.depositButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
        
        self.selectWithdrawButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.withdrawButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
        
        self.selectTransferButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.transferButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
        
        self.logoutButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.logoutButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
    }
    
    func addSubviewsAndConstraints() {
        [viewTitle, selectDepositButton, selectWithdrawButton, selectTransferButton, logoutButton]
            .forEach {
                view.addSubview($0!)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
        
        self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
        self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.selectDepositButton.anchor(top: self.viewTitle.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
        self.selectWithdrawButton.anchor(top: self.selectDepositButton.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
        self.selectTransferButton.anchor(top: self.selectWithdrawButton.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
        self.logoutButton.anchor(top: self.selectTransferButton.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 0, right: 40))
        
    }
    
}
