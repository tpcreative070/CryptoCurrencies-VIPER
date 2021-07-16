//
//  CryptoListDataManager.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import Alamofire
import AlamofireObjectMapper

class CryptoListRemoteDataManager : CryptoListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: CryptoListRemoteDataManagerOutputProtocol?
    var clientService : CryptoFetchingDataProtocol?
    
    func retrieveCryptoList() {
        clientService?.fetchingData(completion: { [weak self] (data, error) in
            guard error == nil else {
                self?.remoteRequestHandler?.onError()
                return
            }
            self?.remoteRequestHandler?.onCryptosRetrieved(data)
        })
    }
}
