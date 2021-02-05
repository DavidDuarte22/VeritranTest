//
//  Validators.swift
//  VeritranSDK
//
//  Created by itsupport on 08/01/2021.
//

import Foundation
//TODO: Test validators
public class Validators {
    
    public static func validateWithdrawAmmount(ammount: Decimal, ammountToWithdraw: Decimal) -> AmmountError? {
        if ammountToWithdraw < 1 {
            return AmmountError.invalidAmmount
        }
        else if ammountToWithdraw > ammount {
            return AmmountError.overdraft
        }
        return nil
    }
    
    public static func validateDepositAmmount(ammountToDeposit: Decimal) -> AmmountError? {
        if ammountToDeposit < 1 {
            return AmmountError.invalidAmmount
        }
        return nil
    }
    
    public static func validateUser(usersList: [User], user: User) -> CustomError? {
        // TODO: Handle creating error or add another custom error
        if (user.identifier == "" || user.name == "") {
            return CustomError.userNotFound
        }
        if (usersList.first(where: {
            $0.identifier == user.identifier
        }) != nil) {
            return CustomError.userNotFound
        }
        return nil
    }
}
