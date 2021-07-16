//
//  CryptoListInteractorTests.swift
//  CryptoCurrencies-VIPERTests
//
//  Created by phong070 on 15/07/2021.
//

import XCTest
@testable import CryptoCurrencies_VIPER

class CryptoListInteractorTests: XCTestCase {
    
    let interactor: CryptoListInteractorInputProtocol & CryptoListRemoteDataManagerOutputProtocol = CryptoListInteractor()
    let remoteDataManager: CryptoListRemoteDataManagerInputProtocol = CryptoListRemoteDataManager()
    let clientService  = MockClientService()
    var fakeInteractionOutput = FakeInteractionOutput()
    
    func fakeData() -> [CryptoModel] {
        return [CryptoModel(base: "Litecoin", counter: "", buyPrice: "1", sellPrice: "1", icon: "", name: "Litecoin"),
                                     CryptoModel(base: "Neo", counter: "", buyPrice: "1", sellPrice: "1", icon: "", name: "Neo"),
                                     CryptoModel(base: "Bitcoin", counter: "", buyPrice: "1", sellPrice: "1", icon: "", name: "Bitcoin")
        ]
    }
    
    final class MockClientService : CryptoFetchingDataProtocol {
        var error : Error? = NSError(domain: "", code: -1, userInfo: nil)
        func fetchingData(completion: @escaping ([CryptoModel], Error?) -> Void) {
            guard error != nil else {
                completion([],nil)
                return
            }
            completion([],error)
        }
    }
    
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
    
    override func setUp()  {
        remoteDataManager.clientService = clientService
        interactor.presenter = fakeInteractionOutput
    }
    
    func testFetchingDataWithSuccess(){
        clientService.error = nil
        remoteDataManager.retrieveCryptoList()
        XCTAssertNil(clientService.error)
    }
    
    func testFetchingDataWithFailure(){
        clientService.error = NSError(domain: "", code: -1, userInfo: nil)
        remoteDataManager.retrieveCryptoList()
        XCTAssertNotNil(clientService.error)
    }
    
    func testFilterCryptoIsEmptyInput(){
        interactor.filterCrypto(original: [], searchText: "")
        XCTAssertTrue(interactor.enumInteractor == EnumInteractor.empty)
    }
    
    func testFilterCryptoHasValueInput(){
        interactor.filterCrypto(original: [], searchText: "Bitcoin")
        XCTAssertTrue(interactor.enumInteractor == EnumInteractor.hasValue)
    }
    
    func testFilterCryptoResponseWithValues(){
        interactor.filterCrypto(original: fakeData(), searchText: "Bitcoin")
        XCTAssertTrue(fakeInteractionOutput.data.count>0)
    }
    
    func testFilterCryptoResponseWithNoValues(){
        interactor.filterCrypto(original: fakeData(), searchText: "Bitcoin-Z")
        XCTAssertTrue(fakeInteractionOutput.data.count==0)
    }
    
}
