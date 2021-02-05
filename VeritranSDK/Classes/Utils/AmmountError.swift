//
//  CustomError.swift
//  VeritranSDK
//
//  Created by itsupport on 07/01/2021.
//

import Foundation

public enum AmmountError: Error {
    case invalidAmmount
    case overdraft
}

extension AmmountError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidAmmount:
            return String("You provide an invalid ammount for this operation")
        case .overdraft:
            return String("This ammount produce an overdraft. Set a lower ammount to withdraw")
        }
    }
}

public enum CustomError: Error {
    case userNotFound
    case accountNotFound
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNotFound:
            return String("The user not exist")
        case .accountNotFound:
            return String("The user doesn't have this account")
        }
    }
}
