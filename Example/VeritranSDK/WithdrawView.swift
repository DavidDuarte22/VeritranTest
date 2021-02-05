//
//  WithdrawView.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 11/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class WithdrawViewImpl: UIViewController {
    let viewModel: WithdrawViewModelImpl
    
    required init(viewModel: WithdrawViewModelImpl) {
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
        
        self.withdrawButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)

    }
    
    @objc private func depositTapped(sender: UIButton) {
        // TODO: Avoid string input in textfield and create validator of conversion
        guard let ammountToDeposit = Decimal(string: ammountTextField.text ?? "") else { return }
        self.viewModel.makeWithdraw(ammount: ammountToDeposit)
    }
    
    //MARK: View properties
    var viewTitle: UILabel!
    var ammountText: UILabel!
    var ammountTextField: UITextField!
    var withdrawButton: UIButton!
    
    func setViewProperties() {
        self.viewTitle = {
            let titleLabel = UILabel ()
            titleLabel.numberOfLines = 2
            titleLabel.text = self.viewModel.titleText
            return titleLabel
        }()
        
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
        
        self.withdrawButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.setTitle(self.viewModel.depositButtonText, for: .normal)
            button.setTitleColor(.black, for: .normal)
            return button
         }()
    }
    
    func addSubviewsAndConstraints() {
        [viewTitle, ammountText, ammountTextField, withdrawButton]
            .forEach {
                view.addSubview($0!)
                $0?.translatesAutoresizingMaskIntoConstraints = false
            }
        
        self.viewTitle.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
        self.viewTitle.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.ammountText.anchor(top: self.viewTitle.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 30, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        self.ammountTextField.anchor(top: self.viewTitle.bottomAnchor, leading: self.ammountText.trailingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 30))
        
        self.withdrawButton.anchor(top: self.ammountTextField.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 30, left: 40, bottom: 0, right: 40))
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
          return true
       } else {
          return false
       }
    }
}
