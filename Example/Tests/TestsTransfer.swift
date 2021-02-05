//
//  TestsTransfer.swift
//  VeritranSDK_Tests
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import VeritranSDK

class TestsTransfer: XCTestCase {
    
    var mockusers: [User]!
    var mockInterface: UserApiInterface!
    var sdkInstance: VeritranSDK!
    
    // NOTE: userUSDAccount have the same pointer address that user's USDAccount so we can test using a var of that account. Making changes in one impact in the other
    var franciscoUser: User!
    var matiasUser: User!
    var franciscoUserUSDAccount: Account!
    var matiasUserUSDAccount: Account!
    
    override func setUp() {
        super.setUp()
        mockusers = [
            User(identifier: "francisco", name: "Francisco Dominguez", accounts: [.USD: Account(type: Currency.USD, ammount: 100)]),
            User(identifier: "matias", name: "Matias Fernandez", accounts: [.USD: Account(type: Currency.USD, ammount: 100)])
        ]
        mockInterface = UserApiImpl(usersDb: mockusers)
        sdkInstance = VeritranSDK(interface: mockInterface)
        
        franciscoUser = sdkInstance.usersAPI.getUserById(id: "francisco")
        matiasUser = sdkInstance.usersAPI.getUserById(id: "matias")

        self.setUSDAccounts()
    }
    
    // Transfer
    func testTransfer(){
        // Check USD accounts are created.
        guard self.franciscoUserUSDAccount != nil else { return }
        guard self.matiasUserUSDAccount != nil else { return }

        self.franciscoUserUSDAccount.withdrawAmmount(ammountTo: 10) { [weak self] result in
            switch result {
            case .success(_):
                self?.matiasUserUSDAccount.increaseAmmount(ammountTo: 10) { result in
                    switch result {
                    case .success(_):
                        
                        XCTAssertEqual(self?.franciscoUserUSDAccount.getAmmount(), 90)
                        XCTAssertEqual(self?.matiasUserUSDAccount.getAmmount(), 110)
                        
                    case .failure(_):
                        XCTFail("Failed depositing money")
                    }
                }
            case .failure(_):
                XCTFail("Failed withdrawing money")
            }
            
            self?.expectation(description: "transfer").fulfill()
            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }

    func testTransferFailedWithdrawError(){
        // Check USD accounts are created.
        guard self.franciscoUserUSDAccount != nil else { return }
        guard self.matiasUserUSDAccount != nil else { return }

        self.franciscoUserUSDAccount.withdrawAmmount(ammountTo: 101) { [weak self] result in
            switch result {
            case .success(_):
                self?.matiasUserUSDAccount.increaseAmmount(ammountTo: 10) { result in
                    switch result {
                    case .success(_):
                        XCTFail("Shouldn't reach this point")
                    case .failure(_):
                        XCTFail("Shouldn't reach this point")
                    }
                }
            case .failure(_):
                XCTAssertEqual(self?.franciscoUserUSDAccount.getAmmount(), 100)
            }
            
            self?.expectation(description: "transfer").fulfill()
            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }

    func testTransferDepositFailed(){
        // Check USD accounts are created.
        guard self.franciscoUserUSDAccount != nil else { return }
        guard self.matiasUserUSDAccount != nil else { return }

        self.franciscoUserUSDAccount.withdrawAmmount(ammountTo: 10) { [weak self] result in
            switch result {
            case .success(_):
                //force error
                self?.matiasUserUSDAccount.increaseAmmount(ammountTo: -10) { result in
                    switch result {
                    case .success(_):
                        XCTFail("Shouldn't reach this point")
                    case .failure(_):
                        // depositing the money again to the first user
                        self?.franciscoUserUSDAccount.increaseAmmount(ammountTo: 10) { result in
                            switch result {
                            case .success(_):
                                
                                XCTAssertEqual(self?.franciscoUserUSDAccount.getAmmount(), 100)
                                XCTAssertEqual(self?.matiasUserUSDAccount.getAmmount(), 100)
                                
                            case .failure(_):
                                XCTFail("Failed depositing money")
                            }
                        }
                    }
                }
            case .failure(_):
                XCTFail("Failed withdrawing money")
            }
            
            self?.expectation(description: "transfer").fulfill()
            self?.waitForExpectations(timeout: 5, handler: nil)
        }
    }
    
}

//MARK: Utils for tests
extension TestsTransfer {
    func setUSDAccounts () {
        franciscoUser.getAccountByCurrency(currency: .USD) { result in
            switch result {
            case .success(let account):
                self.franciscoUserUSDAccount = account
            case .failure(_):
                break
            }
        }
        
        matiasUser.getAccountByCurrency(currency: .USD) { result in
            switch result {
            case .success(let account):
                self.matiasUserUSDAccount = account
            case .failure(_):
                break
            }
        }
    }
}
