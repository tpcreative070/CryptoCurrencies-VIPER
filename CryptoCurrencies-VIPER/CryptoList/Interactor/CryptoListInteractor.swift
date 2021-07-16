//
//  CryptoListInteractor.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import Foundation
enum EnumInteractor {
    case empty
    case hasValue
    case none
}

class CryptoListInteractor: CryptoListInteractorInputProtocol {
 
    weak var presenter: CryptoListInteractorOutputProtocol?
    var remoteDatamanager: CryptoListRemoteDataManagerInputProtocol?
    private var timer : Timer?
    var enumInteractor: EnumInteractor = EnumInteractor.none
    func retrieveCryptoList() {
        remoteDatamanager?.retrieveCryptoList()
    }
    
    func filterCrypto(original data: [CryptoModel], searchText : String) {
        guard !searchText.isEmpty else {
            presenter?.didRetrieveCryptos(data)
            self.enumInteractor = .empty
            return
        }
        self.enumInteractor = .hasValue
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

