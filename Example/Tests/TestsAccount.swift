//
//  TestsAccount.swift
//  VeritranSDK_Tests
//
//  Created by itsupport on 07/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import VeritranSDK

class TestsAccount: XCTestCase {
    
    var mockusers: [User]!
    var mockInterface: UserApiInterface!
    var sdkInstance: VeritranSDK!
    
    // NOTE: userUSDAccount have the same pointer address that user's USDAccount so we can test using a var of that account. Making changes in one impact in the other
    var user: User!
    var userUSDAccount: Account!
    
    override func setUp() {
        super.setUp()
        mockusers = [ User(identifier: "francisco", name: "Pancho", accounts: [.USD: Account(type: Currency.USD, ammount: 100)]) ]
        mockInterface = UserApiImpl(usersDb: mockusers)
        sdkInstance = VeritranSDK(interface: mockInterface)
        
        user = sdkInstance.usersAPI.getUserById(id: "francisco")
        self.setUSDAccount()
    }

    // Deposit
    
    
    
    func testDepositMoneyInAccount() {
        guard self.userUSDAccount != nil else { return }
            
        self.userUSDAccount.increaseAmmount(ammountTo: 10) { [weak self] result in
            switch result {
            case .success(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 110)
            case .failure(_):
                XCTFail("deposit has failed")
            }
            self?.expectation(description: "deposit").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }
    
    func testDepositInvalidMoneyInAccount() {
        guard self.userUSDAccount != nil else { return }
        
        self.userUSDAccount.increaseAmmount(ammountTo: 0) { [weak self] result in
            switch result {
            case .success(_):
                XCTFail("The deposit shouldn't be successful")
            case .failure(_):
                
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 100)
            }
            self?.expectation(description: "deposit").fulfill()
            
            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }
    
    func testDepositInvalidNegativeMoneyInAccount() {
        guard self.userUSDAccount != nil else { return }

        self.userUSDAccount.increaseAmmount(ammountTo: -100) { [weak self] result in
            switch result {
            case .success(_):
                XCTFail("The deposit shouldn't be successful")
            case .failure(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 100)
            }

            self?.expectation(description: "deposit").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }


    // Withdraw

    func testWithdrawMoneyInAccount() {
        guard self.userUSDAccount != nil else { return }

        self.userUSDAccount.withdrawAmmount(ammountTo: 10) { [weak self] result in
            switch result {
            case .success(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 90)
            case .failure(_):
                XCTFail("deposit has failed")
            }
            self?.expectation(description: "withdraw").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }

    func testWithdrawMoneyInAccount2() {
        guard self.userUSDAccount != nil else { return }

        self.userUSDAccount.withdrawAmmount(ammountTo: 100) { [weak self] result in
            switch result {
            case .success(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 0)
            case .failure(_):
                XCTFail("deposit has failed")
            }
            self?.expectation(description: "withdraw").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }

    func testWithdrawInvalidMoneyInAccount() {
        guard self.userUSDAccount != nil else { return }

        self.userUSDAccount.withdrawAmmount(ammountTo: 0) { [weak self] result in
            switch result {
            case .success(_):
                XCTFail("The withdraw shouldn't be successful")
            case .failure(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 100)
            }
            self?.expectation(description: "withdraw").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }

    func testWithdrawOverdraftInAccount() {
        guard self.userUSDAccount != nil else { return }

        self.userUSDAccount.withdrawAmmount(ammountTo: 101) { [weak self] result in
            switch result {
            case .success(_):
                XCTFail("The withdraw shouldn't be successful")
            case .failure(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 100)
            }

            self?.expectation(description: "withdraw").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }

    func testWithdrawInvalidNegativeMoneyInAccount() {
        guard self.userUSDAccount != nil else { return }

        self.userUSDAccount.withdrawAmmount(ammountTo: -100) { [weak self] result in
            switch result {
            case .success(_):
                XCTFail("The withdraw shouldn't be successful")
            case .failure(_):
                XCTAssertEqual(self?.userUSDAccount.getAmmount(), 100)
            }

            self?.expectation(description: "withdraw").fulfill()

            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }
}

//MARK: Utils for tests
extension TestsAccount {
    func setUSDAccount () {
        user.getAccountByCurrency(currency: .USD) { result in
            switch result {
            case .success(let account):
                self.userUSDAccount = account
            case .failure(_):
                break
            }
        }
    }
}
