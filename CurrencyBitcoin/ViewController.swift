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
    

    var finalURL: String?
    var symbol: String?
    private var model = logicaDeNegocio()
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPicker.delegate = self
        currentPicker.dataSource = self
    }
    
    func formatearNumero(number : String) {

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.currenciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.currenciesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(model.currenciesArray[row])
        finalURL = model.baseURL+model.currenciesArray[row]
        symbol = model.currencyArray[row]
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
            let formater = NumberFormatter()
            formater.groupingSeparator = "."
            formater.numberStyle = .decimal
            let formattedNumber = formater.string(from: bitCoinResult as NSNumber)
            labelPrecio.text = String(symbol!+formattedNumber!)
        }else{
            labelPrecio.text = "Servicio no Disponible"
        }
    }
}

