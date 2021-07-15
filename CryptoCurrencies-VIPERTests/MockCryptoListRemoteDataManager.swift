//
//  MockCryptoListRemoteDataManager.swift
//  CryptoCurrencies-VIPERTests
//
//  Created by phong070 on 15/07/2021.
//

import Foundation
@testable import CryptoCurrencies_VIPER
class MockCryptoListRemoteDataManager : CryptoListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: CryptoListRemoteDataManagerOutputProtocol?
    var error : Error? = NSError(domain: "", code:-1, userInfo: nil)
    
    func retrieveCryptoList() {
        guard error != nil else {
            self.remoteRequestHandler?.onCryptosRetrieved([CryptoModel]())
            return
        }
        self.remoteRequestHandler?.onError()
    }
}
