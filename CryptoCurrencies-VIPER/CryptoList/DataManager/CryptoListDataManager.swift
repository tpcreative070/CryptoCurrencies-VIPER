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
    
    func retrieveCryptoList() {
        Alamofire
            .request(Endpoints.Posts.fetch.url, method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<CryptosModel>) in
                switch response.result {
                case .success(let crypto):
                    self.remoteRequestHandler?.onCryptosRetrieved(crypto.data)
                case .failure( _):
                    self.remoteRequestHandler?.onError()
                }
            })
    }
}
