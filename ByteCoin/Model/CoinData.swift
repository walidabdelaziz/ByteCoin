//
//  CoinData.swift
//  ByteCoin
//
//  Created by Walid  on 7/15/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import Foundation
struct CoinData: Decodable {
    let asset_id_quote: String
    let rate: Double
}
