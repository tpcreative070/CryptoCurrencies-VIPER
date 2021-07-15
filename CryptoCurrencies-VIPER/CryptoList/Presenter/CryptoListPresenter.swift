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
    
    func showCryptoDetail(forPost post: CryptoModel) {
        router?.presentCryptoDetailScreen(from: view!, forPost: post)
    }
}

extension CryptoListPresenter: CryptoListInteractorOutputProtocol {
    
    func didRetrieveCryptos(_ posts: [CryptoModel]) {
        view?.hideLoading()
        view?.showCryptos(with: posts)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}


