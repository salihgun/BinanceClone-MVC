//
//  Double+Ext.swift
//  BinanceClone
//
//  Created by Salih Gün on 10.03.2024.
//

import Foundation

extension Double {
    func abbreviatedNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        var result = ""
        switch self {
        case 1_000_000..<1_000_000_000:
            let value = self / 1_000_000
            result = "\(formatter.string(from: NSNumber(value: value)) ?? "")M"
        case 1_000_000_000..<1_000_000_000_000:
            let value = self / 1_000_000_000
            result = "\(formatter.string(from: NSNumber(value: value)) ?? "")B"
        default:
            result = formatter.string(from: NSNumber(value: self)) ?? ""
        }

        return result
    }
}
