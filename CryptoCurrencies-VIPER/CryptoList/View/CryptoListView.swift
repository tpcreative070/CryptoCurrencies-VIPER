//
//  CryptoListView.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import UIKit
import PKHUD
class CryptoListView : UIViewController {
    var presenter: CryptoListPresenterProtocol?
    var cryptoList: [CryptoModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        presenter?.viewDidLoad()
    }
}

extension CryptoListView: CryptoListViewProtocol {
    
    func showCryptos(with posts: [CryptoModel]) {
        cryptoList = posts
        tableView.reloadData()
    }
    
    func showError() {
        HUD.flash(.label("Internet not connected"), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}

extension CryptoListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let post = cryptoList[indexPath.row]
        cell.set(forPost: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presenter?.showPostDetail(forPost: cryptoList[indexPath.row])
    }
    
}
