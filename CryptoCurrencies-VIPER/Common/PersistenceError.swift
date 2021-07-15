//
//  PersistenceError.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import Foundation

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}
