//
//  CryptoTableViewCell.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import UIKit
import AlamofireImage

class CryptoTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    func set(forPost post: CryptoModel) {
        self.selectionStyle = .none
        lbName?.text = post.name
        lbPrice?.text = post.sellPrice
        let url = URL(string: post.icon)!
        imgIcon?.af_setImage(withURL: url, placeholderImage: .none)
    }
}

