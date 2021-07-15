//
//  CryptoListInteractor.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import Foundation

class CryptoListInteractor: CryptoListInteractorInputProtocol {
 
    weak var presenter: CryptoListInteractorOutputProtocol?
    var localDatamanager: CryptoListLocalDataManagerInputProtocol?
    var remoteDatamanager: CryptoListRemoteDataManagerInputProtocol?
    
    func retrieveCryptoList() {
        do {
            if let postList = try localDatamanager?.retrieveCryptoList() {
                let postModelList = postList.map() {
                    return CryptoModel(base: $0.base, counter: $0.counter, buyPrice: $0.buyPrice, sellPrice: $0.sellPrice, icon: $0.icon, name: $0.name)
                }
                if  postModelList.isEmpty {
                    remoteDatamanager?.retrieveCryptoList()
                }else{
                   presenter?.didRetrieveCryptos(postModelList)
                }
            } else {
                remoteDatamanager?.retrieveCryptoList()
            }
        } catch {
            presenter?.didRetrieveCryptos([])
        }
    }
}

extension CryptoListInteractor: CryptoListRemoteDataManagerOutputProtocol {
    func onCryptosRetrieved(_ posts: [CryptoModel]) {
        presenter?.didRetrieveCryptos(posts)
    }
    
    func onError() {
        presenter?.onError()
    }
}

