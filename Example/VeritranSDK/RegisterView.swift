//
//  RegisterView.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 10/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class RegisterViewImpl: UIViewController {
    let viewModel: RegisterViewModelImpl
    
    required init(viewModel: RegisterViewModelImpl) {
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
        
        self.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

    }
    
    @objc private func registerTapped(sender: UIButton) {
        guard let identifier = identifierTextField.text else { return }
        guard let name = userNameTextField.text else { return }

        self.viewModel.registerNewUser(withIdentifier: identifier, withName: name)
    }
    
    // MARK: View properties
    var viewTitle: UILabel!
    var identifierText: UILabel!
    var identifierTextField: UITextField!
    var nameText: UILabel!
    var userNameTextField: UITextField!
    var registerButton: UIButton!
    
    func setViewProperties() {
        self.viewTitle = {
            let titleLabel = UILabel ()
            titleLabel.text = self.viewModel.titleText
            return titleLabel
        }()
        
        self.identifierText = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = self.viewModel.identifierText 
            return label
        }()
        
        self.identifierTextField = {
            let textField = UITextField()
            textField.backgroundColor = .groupTableViewBackground
            return textField
        }()
        
        self.nameText = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text =  self.viewModel.usernameText
            return label
        }()
        
        self.userNameTextField = {
            let textField = UITextField()
            textField.backgroundColor = .groupTableViewBackground
            return textField
        }()
        
        self.registerButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.registerButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
    }
    
    func addSubviewsAndConstraints() {
        [viewTitle, identifierText, identifierTextField, nameText, userNameTextField, registerButton]
            .forEach {
                view.addSubview($0!)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
        
        self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.identifierText.anchor(top: self.viewTitle.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 30, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        self.identifierTextField.anchor(top: self.viewTitle.bottomAnchor, leading: self.identifierText.trailingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 30))
        
        self.nameText.anchor(top: self.identifierText.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        self.userNameTextField.anchor(top: self.identifierText.bottomAnchor, leading: self.nameText.trailingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 30))
        
        self.registerButton.anchor(top: self.nameText.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
    }
}
