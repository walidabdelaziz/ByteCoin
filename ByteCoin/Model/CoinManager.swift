
//  CoinManager.swift
//  ByteCoin
//
//  Created by Walid  on 7/15/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdatePrice(byteCoin: CoinModel)
    func didFailWithError(error:Error)
}
struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "FED010FC-C2E9-4A1F-99B6-2F721A9DA5E9"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    var delegate: CoinManagerDelegate?
    
    func fetchData(currency: String)
    {
        let fullURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(With: fullURL)
    }
    func performRequest(With urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }else {
                    if let safeData = data{
                        if let byteCoin = self.parseData(safeData){
                            self.delegate?.didUpdatePrice(byteCoin: byteCoin)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseData(_ coindata: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do{
            let decodeddata = try decoder.decode(CoinData.self, from: coindata)
            let currencyName = decodeddata.asset_id_quote
            let price = decodeddata.rate
            let byteCoin = CoinModel(name: currencyName, price: price)
            return byteCoin
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
