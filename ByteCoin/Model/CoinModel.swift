//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Walid  on 7/15/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import Foundation
struct CoinModel {
    let name:String
    let price:Double
    
    var priceString:String{
        return String(format: "%.1f", price)
    }
}
