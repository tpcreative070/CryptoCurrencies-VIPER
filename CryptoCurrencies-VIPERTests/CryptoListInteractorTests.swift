//
//  CryptoListInteractorTests.swift
//  CryptoCurrencies-VIPERTests
//
//  Created by phong070 on 15/07/2021.
//

import XCTest
@testable import CryptoCurrencies_VIPER

class CryptoListInteractorTests: XCTestCase {
    
    let presenter: CryptoListPresenterProtocol & CryptoListInteractorOutputProtocol = CryptoListPresenter()
    let interactor: CryptoListInteractorInputProtocol & CryptoListRemoteDataManagerOutputProtocol = CryptoListInteractor()
    let remoteDataManager: CryptoListRemoteDataManagerInputProtocol = CryptoListRemoteDataManager()
    let router : CryptoListRouterProtocol = CryptoListRouter()
    
    final class FakeInteractionOutput : CryptoListInteractorOutputProtocol {
        var data : [CryptoModel] = []
        var isRequestFetchingData = false
        var error : Error?
        
        func didRetrieveCryptos(_ posts: [CryptoModel]) {
            self.data = posts
        }
        
        func didFilterCryptos(_ cryptos: [CryptoModel]) {
            self.data = cryptos
        }
        
        func requestFetching() {
            self.isRequestFetchingData = true
        }
        
        func onError() {
            self.error = NSError(domain: "", code: -1, userInfo: nil)
        }
    }
    
    final class FakeInteractorInput : CryptoListInteractorInputProtocol {
        var presenter: CryptoListInteractorOutputProtocol?
        
        var remoteDatamanager: CryptoListRemoteDataManagerInputProtocol?
        
        func retrieveCryptoList() {
            
        }
        
        func filterCrypto(original data: [CryptoModel], searchText: String) {
            
        }
        
        func startTimer() {
            
        }
        
        func stopTimer() {
            
        }
    }
    
    final class FakeRemoteDataManagerInput : CryptoListRemoteDataManagerInputProtocol {
        var remoteRequestHandler: CryptoListRemoteDataManagerOutputProtocol?
        func retrieveCryptoList() {
            
        }
    }
    
    override func setUp()  {
        interactor.presenter = FakeInteractionOutput()
        interactor.remoteDatamanager = FakeRemoteDataManagerInput()
    }
}
