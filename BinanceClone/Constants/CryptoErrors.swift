//
//  CryptoErrors.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import Foundation

enum CryptoErrors: String, Error {
    case networkError = "Unable to fetch data."
    case parsingError = "Parsing error"
}
