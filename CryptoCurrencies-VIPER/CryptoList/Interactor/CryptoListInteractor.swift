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
    private var timer : Timer?
    
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
    
    func filterCrypto(original data: [CryptoModel], searchText : String) {
        guard !searchText.isEmpty else {
            presenter?.didRetrieveCryptos(data)
            return
        }
        let mResult = data.filter({$0.name.contains(searchText)})
        presenter?.didFilterCryptos(mResult)
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: {[weak self] (timer) in
            self?.presenter?.requestFetching()
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
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

