//
//  CryptoListRouter.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import UIKit

class CryptoListRouter : CryptoListRouterProtocol {
    
    class func createCryptoListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "CryptoNavigationController")
        if let view = navController.children.first as? CryptoListView {
            let presenter: CryptoListPresenterProtocol & CryptoListInteractorOutputProtocol = CryptoListPresenter()
            let interactor: CryptoListInteractorInputProtocol & CryptoListRemoteDataManagerOutputProtocol = CryptoListInteractor()
            let remoteDataManager: CryptoListRemoteDataManagerInputProtocol = CryptoListRemoteDataManager()
            let router : CryptoListRouterProtocol = CryptoListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
