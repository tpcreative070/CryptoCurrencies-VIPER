//
//  CryptoPresenter.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import Foundation
class CryptoListPresenter: CryptoListPresenterProtocol {
   
    weak var view: CryptoListViewProtocol?
    var interactor: CryptoListInteractorInputProtocol?
    var router: CryptoListRouterProtocol?
   
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveCryptoList()
    }
        
    func filterCrypto(original data: [CryptoModel], searchText: String) {
        interactor?.filterCrypto(original: data, searchText: searchText)
    }
    
    func startTimer() {
        interactor?.startTimer()
    }
    
    func stopTimer() {
        interactor?.stopTimer()
    }
}

extension CryptoListPresenter: CryptoListInteractorOutputProtocol {
    
    func didRetrieveCryptos(_ posts: [CryptoModel]) {
        view?.hideLoading()
        view?.showCryptos(with: posts)
    }
    
    func didFilterCryptos(_ cryptos: [CryptoModel]) {
        view?.showFilterCryptos(with: cryptos)
    }
    
    func requestFetching() {
        view?.requestFetching()
    }
        
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}


