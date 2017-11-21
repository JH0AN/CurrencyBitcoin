//
//  Logic.swift
//  CurrencyBitcoin
//
//  Created by practica on 15/11/17.
//  Copyright © 2017 SebasTitan. All rights reserved.
//

import Foundation

struct logicaDeNegocio {
    let currenciesArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","EGP","KZT","PHP"]
    let currencyArray =
        ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr","£","лв","₱"]
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    func currenciesArray(row:Int) -> String {
        return currenciesArray[row]
    }
    func currencyArray(row:Int) -> String {
        return currencyArray[row]
    }
}
