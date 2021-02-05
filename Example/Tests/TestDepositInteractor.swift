//
//  TestDepositInteractor.swift
//  VeritranSDK_Tests
//
//  Created by itsupport on 20/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import VeritranSDK

class TestDepositInteractor: XCTestCase {
    
    var interactor: DepositInteractorInterface!
    var mockRepo: User!
    
    let ammount: Decimal = 100.00

    
    let userID: String = "francisco"
    override func setUp() {
        super.setUp()
        mockRepo = User(identifier: "francisco", name: "Francisco Pancho", accounts: [.USD: Account(identifier: userID, type: .USD, ammount: ammount)
        ])
        interactor = DepositInteractorImpl(userRepository: mockRepo)
        
    }

    // Deposit
    // deposit 10 to an account with 100 . result assert 110
    func testDeposit() {
        let result = self.interactor.depositMoney(ammount: 10, accountID: userID)
        
        switch result {
            case .success(let newAmmount):
                XCTAssertEqual(ammount + 10, newAmmount)
        case .failure(_):
                XCTFail("deposit failed")
        }
    }
}

