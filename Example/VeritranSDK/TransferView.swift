//
//  TransferView.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TransferViewImpl: UIViewController {
    let viewModel: TransferViewModelImpl
    
    required init(viewModel: TransferViewModelImpl) {
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
        
        self.viewModel.userSearched.bind { _ in
            if (self.viewModel.userSearched.value != nil) { self.userSetted() }
        }
        
        self.lookForUserButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        self.transferButton.addTarget(self, action: #selector(transferTapped), for: .touchUpInside)

    }
    
    @objc private func searchTapped(sender: UIButton) {
        guard let userToSearch = userTextField.text else { return }
        self.viewModel.lookForUser(withIdentifier: userToSearch)
    }
    
    @objc private func transferTapped(sender: UIButton) {
        // TODO: Avoid string input in textfield and create validator of conversion
        guard let ammountToTransfer = Decimal(string: ammountTextField.text ?? "") else { return }
        self.viewModel.makeTransfer(ammount: ammountToTransfer)
    }
    
    //MARK: View properties
    var viewTitle: UILabel!
    var userText: UILabel!
    var userTextField: UITextField!
    var lookForUserButton: UIButton!

    var ammountText: UILabel!
    var ammountTextField: UITextField!
    var transferButton: UIButton!
    
    
    
    func setViewProperties() {
        self.viewTitle = {
            let titleLabel = UILabel ()
            titleLabel.numberOfLines = 2
            titleLabel.text = self.viewModel.titleText
            return titleLabel
        }()
        
        // Look for User
        self.userText = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = self.viewModel.searchUserText
            return label
        }()
        
        self.userTextField = {
            let textField = UITextField()
            textField.backgroundColor = .groupTableViewBackground
            return textField
        }()
        
        self.lookForUserButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.searchForUserButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
        
        // Ammount to transfer
        self.ammountText = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = self.viewModel.ammountText
            return label
        }()
        
        self.ammountTextField = {
            let textField = UITextField()
            textField.backgroundColor = .groupTableViewBackground
            return textField
        }()
        
        self.transferButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.transferButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
    }
    
    func addSubviewsAndConstraints() {
        [viewTitle, userText, userTextField, lookForUserButton]
            .forEach {
                view.addSubview($0!)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
        
        self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
        self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.userText.anchor(top: self.viewTitle.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 30, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        self.userTextField.anchor(top: self.viewTitle.bottomAnchor, leading: self.userText.trailingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 30))
        
        self.lookForUserButton.anchor(top: self.userTextField.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
    }
    
    func userSetted() {
        self.viewTitle.text = self.viewModel.titleText
        
        [ammountText, ammountTextField, transferButton]
            .forEach {
                view.addSubview($0!)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
        
        
        self.ammountText.anchor(top: self.lookForUserButton.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 30, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        self.ammountTextField.anchor(top: self.lookForUserButton.bottomAnchor, leading: self.ammountText.trailingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 30))
        
        self.transferButton.anchor(top: self.ammountTextField.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
          return true
       } else {
          return false
       }
    }
}
