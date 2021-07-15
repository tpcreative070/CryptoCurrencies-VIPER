//
//  CryptoListProtocols.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//
import UIKit

protocol CryptoListDataManagerOutputProtocol : AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onCryptosRetrieved(_ posts: [CryptoModel])
    func onError()
}

protocol CryptoListRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: CryptoListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveCryptoList()
}


protocol CryptoListInteractorInputProtocol: AnyObject {
    var presenter: CryptoListInteractorOutputProtocol? { get set }
    var localDatamanager: CryptoListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CryptoListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveCryptoList()
    func filterCrypto(original data: [CryptoModel], searchText : String)
    func startTimer()
    func stopTimer()
}

protocol CryptoListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrieveCryptos(_ posts: [CryptoModel])
    func didFilterCryptos(_ cryptos : [CryptoModel])
    func requestFetching()
    func onError()
}

protocol CryptoListLocalDataManagerInputProtocol: AnyObject {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrieveCryptoList() throws -> [CryptoModel]
    func saveCrypto(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}

protocol CryptoListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onCryptosRetrieved(_ posts: [CryptoModel])
    func onError()
}


protocol CryptoListViewProtocol: AnyObject {
    var presenter: CryptoListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showCryptos(with posts: [CryptoModel])
    
    func showFilterCryptos(with posts : [CryptoModel])
    
    func requestFetching()
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol CryptoListPresenterProtocol: AnyObject {
    var view: CryptoListViewProtocol? { get set }
    var interactor: CryptoListInteractorInputProtocol? { get set }
    var router: CryptoListRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showCryptoDetail(forPost post: CryptoModel)
    func filterCrypto(original data : [CryptoModel],searchText : String)
    func startTimer()
    func stopTimer()
}

protocol CryptoListRouterProtocol: AnyObject {
    static func createCryptoListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentCryptoDetailScreen(from view: CryptoListViewProtocol, forPost post: CryptoModel)
}

