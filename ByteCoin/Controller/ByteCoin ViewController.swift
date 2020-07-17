//
//  ViewController.swift
//  ByteCoin
//
//  Created by Walid  on 7/15/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController {

    
    
    var coinmanager = CoinManager()
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        coinmanager.delegate = self
    }


}

//MARK:- CoinManagerDelegate

extension ByteCoinViewController: CoinManagerDelegate{
    func didUpdatePrice(byteCoin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = byteCoin.name
            self.priceLabel.text = byteCoin.priceString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

//MARK: - UIPickerViewDataSource


extension ByteCoinViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinmanager.currencyArray.count
    }
    
    
}

//MARK: - UIPickerViewDelegate

extension ByteCoinViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinmanager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinmanager.currencyArray[row]
        coinmanager.fetchData(currency: selectedCurrency)
    }
    
}
