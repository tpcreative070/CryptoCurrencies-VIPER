//
//  Endpoints.swift
//  CryptoCurrencies-VIPER
//
//  Created by phong070 on 15/07/2021.
//

import Foundation
import Foundation

struct API {
    static let baseUrl = "https://www.coinhako.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Posts: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/api/v3/price/all_prices_for_mobile?counter_currency=USD"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
