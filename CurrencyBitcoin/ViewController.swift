//
//  ViewController.swift
//  CurrencyBitcoin
//
//  Created by practica on 1/11/17.
//  Copyright © 2017 SebasTitan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet var currentPicker: UIPickerView!
    @IBOutlet var labelPrecio: UILabel!
    
    let currenciesArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","EGP","KZT","PHP"]
    let currencyArray =
        ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"
        ]
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var finalURL: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPicker.delegate = self
        currentPicker.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currenciesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currenciesArray[row])
        finalURL = baseURL+currenciesArray[row]
        getBitcoinData(url: finalURL!)
    }
    
    //MARK: -Networking
    
    func getBitcoinData(url: String)
    {
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess
            {
                let bitCoinJSON : JSON = JSON(response.result.value!)
                self.updateBitcoinData(json: bitCoinJSON)
            }else{
               print("Error procesando la tarea... \(response.result.error)")
                self.labelPrecio.text = "Se presento un problema en la conexion"
            }
        }
    }
    
    func updateBitcoinData(json: JSON)
    {
        if let bitCoinResult = json["ask"].double{
            labelPrecio.text = String(bitCoinResult)
        }else{
            labelPrecio.text = "Servicio no Disponible"
        }
    }
}

