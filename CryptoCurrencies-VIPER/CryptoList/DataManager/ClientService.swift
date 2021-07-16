//
//  ClientService.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 16/07/2021.
//

import Alamofire

final class ClientService : CryptoFetchingDataProtocol {
    func fetchingData(completion: @escaping ([CryptoModel], Error?) -> Void) {
        Alamofire
            .request(Endpoints.Posts.fetch.url, method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<CryptosModel>) in
                switch response.result {
                case .success(let crypto):
                    completion(crypto.data,nil)
                case .failure( _):
                    completion([],response.error)
                }
            })
    }
}


