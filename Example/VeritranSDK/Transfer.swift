//
//  Transfer.swift
//  VeritranSDK_Example
//
//  Created by itsupport on 12/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import VeritranSDK

struct Transfer {
    let fromUser: User
    let fromAccount: Account
    let toUser: User
    let toAccount: Account
    let ammount: Decimal
}
