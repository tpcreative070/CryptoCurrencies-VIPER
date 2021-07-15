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
    private var restoreList : [CryptoModel] = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveCryptoList()
    }
    
    func showCryptoDetail(forPost post: CryptoModel) {
        router?.presentCryptoDetailScreen(from: view!, forPost: post)
    }
    
    func filterCrypto(original data: [CryptoModel], searchText: String) {
        interactor?.filterCrypto(original: data, searchText: searchText)
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
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}


