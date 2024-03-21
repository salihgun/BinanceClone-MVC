//
//  Constants.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import UIKit

enum Colors {
    static let primaryColor = UIColor(named: "PrimaryDarkColor")
    static let primaryBackgroundColor = UIColor(named: "PrimaryBackgroundColor")
    static let customRed = UIColor(named: "CustomRed")
    static let customGreen = UIColor(named: "CustomGreen")
}

enum Icons {
    static let search = UIImage(systemName: "magnifyingglass")
    static let ellipsis = UIImage(systemName: "ellipsis")
    static let chevronUp = UIImage(systemName: "arrowtriangle.up.fill")
    static let chevronDown = UIImage(systemName: "arrowtriangle.down.fill")
}

enum Network {
    static let baseURL = "https://api.coinlore.net/api/tickers/?start=100&limit=100"
}
