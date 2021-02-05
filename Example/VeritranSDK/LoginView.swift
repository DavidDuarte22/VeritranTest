//
//  LoginView.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol LoginViewInterface {
    
}


class LoginViewImpl: UIViewController {
    
    let viewModel: LoginViewModelImpl
    
    required init(viewModel: LoginViewModelImpl) {
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
        
        self.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        self.registerUserButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
        

    @objc private func loginTapped(sender: UIButton) {
        guard let identifier = userTextField.text else { return }
        self.viewModel.signInUser(withIdentifier: identifier)
    }
    
    @objc private func registerTapped(sender: UIButton) {
        self.viewModel.navigateToRegisterUser()
    }
    // MARK: View properties
    var userTextField: UITextField!
    var viewTitle: UILabel!
    var loginButton: UIButton!
    var registerUserButton: UIButton!
    
    func setViewProperties() {
        self.userTextField = {
            let textField = UITextField()
            textField.backgroundColor = .groupTableViewBackground
            return textField
        }()
        
        self.viewTitle = {
            let titleLabel = UILabel ()
            titleLabel.text = self.viewModel.titleText
            return titleLabel
        }()
        
        self.loginButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.loginButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
        
        self.registerUserButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.registerButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
    }
    
    func addSubviewsAndConstraints() {
        [ self.viewTitle, self.userTextField, self.loginButton, self.registerUserButton].forEach {
            guard let newView = $0 else { return }
            view.addSubview(newView)
            newView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.userTextField.anchor(top: self.viewTitle.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 30, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        self.loginButton.anchor(top: self.viewTitle.topAnchor, leading: self.userTextField.trailingAnchor, bottom: self.userTextField.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 10, bottom: 0, right: 30), size: .init(width: 100, height: 0))
        
        self.registerUserButton.anchor(top: self.loginButton.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
    }
}
