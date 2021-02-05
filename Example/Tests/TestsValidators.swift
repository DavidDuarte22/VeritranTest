//
//  TestsValidators.swift
//  VeritranSDK_Tests
//
//  Created by itsupport on 08/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import VeritranSDK

class TestsValidators: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // Deposit
    func testIncreaseAmmount() {
        if let error = Validators.validateDepositAmmount(ammountToDeposit: 100) {
            XCTFail("Shouldn't receive an error \(error)")
        }
        XCTAssert(true)
    }
    
    func testIncreaseNegativeAmmount() {
        if let error = Validators.validateDepositAmmount(ammountToDeposit: -100) {
            XCTAssertEqual(error.errorDescription, AmmountError.invalidAmmount.errorDescription)
            return
        }
        XCTFail("Should receive an error")
    }
    
    func testIncreaseZeroAmmount() {
        if let error = Validators.validateDepositAmmount(ammountToDeposit: 0) {
            XCTAssertEqual(error.errorDescription, AmmountError.invalidAmmount.errorDescription)
            return
        }
        XCTFail("Should receive an error")
    }
    
    // Withdraw
    func testWithdrawAmmount() {
        if let error = Validators.validateWithdrawAmmount(ammount: 100, ammountToWithdraw: 90) {
            XCTFail("Shouldn't receive an error \(error)")
        }
        XCTAssert(true)
    }
    
    func testOverdraftAmmount() {
        if let error = Validators.validateWithdrawAmmount(ammount: 100, ammountToWithdraw: 110) {
            XCTAssertEqual(error.errorDescription, AmmountError.overdraft.errorDescription)
            return
        }
        XCTFail("Should receive an error")
    }
    
    
    func testWithdrawNegativeAmmount() {
        if let error = Validators.validateWithdrawAmmount(ammount: 100, ammountToWithdraw: -100) {
            XCTAssertEqual(error.errorDescription, AmmountError.invalidAmmount.errorDescription)
            return
        }
        XCTFail("Should receive an error")
    }
    
    func testWithdrawZeroAmmount() {
        if let error = Validators.validateWithdrawAmmount(ammount: 100, ammountToWithdraw: 0) {
            XCTAssertEqual(error.errorDescription, AmmountError.invalidAmmount.errorDescription)
            return
        }
        XCTFail("Should receive an error")
    }
}
