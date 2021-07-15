//
//  CryptoModel.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import ObjectMapper

struct CryptoModel {
    var base = ""
    var counter = ""
    var buyPrice = ""
    var sellPrice = ""
    var icon = ""
    var name = ""
}

extension CryptoModel: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        base      <- map["base"]
        counter   <- map["counter"]
        buyPrice  <- map["buy_price"]
        sellPrice <- map["sell_price"]
        icon     <- map["icon"]
        name     <- map["name"]
    }
}

struct CryptosModel: Mappable {
    var data : [CryptoModel] = []
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        data  <- map["data"]
    }
}
