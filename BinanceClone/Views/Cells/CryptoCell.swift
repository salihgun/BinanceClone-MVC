//
//  CryptoCell.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import UIKit

class CryptoCell: UITableViewCell {
    let pairName = UILabel()
    let unit = UILabel()
    let volume = UILabel()
    let changesLabel = UILabel()
    let lastPrice = UILabel()
    let lastPriceInUnit = UILabel()
    
    static let reuseIdentifier = "CryptoCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configurePairName()
        configureUnit()
        configureVolume()
        configureChangesLabel()
        configureLastPrice()
        configureLastPriceInUnit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(currency: Crypto){
        pairName.text = currency.symbol
        volume.text = currency.volume24.abbreviatedNumber()
        
        let value = Double(currency.percentChange24H) ?? 0.0
        changesLabel.text = "\(value > 0 ? "+" : "-")%\(abs(value))"
        changesLabel.layer.backgroundColor = value > 0 ? Colors.customGreen?.cgColor : Colors.customRed?.cgColor
        
        lastPrice.text = currency.priceUsd
        lastPriceInUnit.text = "$\(currency.priceUsd)"
    }
    
    func configure() {
        backgroundColor = .clear
    }
    
    func configurePairName() {
        addSubview(pairName)
        pairName.translatesAutoresizingMaskIntoConstraints = false
        pairName.textColor = .white
        pairName.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        NSLayoutConstraint.activate([
            pairName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            pairName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
        ])
    }
    
    func configureUnit() {
        addSubview(unit)
        unit.translatesAutoresizingMaskIntoConstraints = false
        unit.textColor = .gray
        unit.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        unit.text = "/USDT"
        
        NSLayoutConstraint.activate([
            unit.leadingAnchor.constraint(equalTo: pairName.trailingAnchor, constant: 5),
            unit.centerYAnchor.constraint(equalTo: pairName.centerYAnchor),
        ])
    }
    
    func configureVolume() {
        addSubview(volume)
        volume.translatesAutoresizingMaskIntoConstraints = false
        volume.textColor = .gray
        volume.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        volume.text = "1,59B"
        
        NSLayoutConstraint.activate([
            volume.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            volume.leadingAnchor.constraint(equalTo: pairName.leadingAnchor),
        ])
    }
    
    func configureChangesLabel() {
        addSubview(changesLabel)
        changesLabel.translatesAutoresizingMaskIntoConstraints = false
        changesLabel.textColor = .white
        changesLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        changesLabel.textAlignment = .center
        changesLabel.layer.masksToBounds = true
        changesLabel.layer.cornerRadius = 5
        changesLabel.layer.cornerCurve = .continuous
        
        
        NSLayoutConstraint.activate([
            changesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            changesLabel.heightAnchor.constraint(equalToConstant: 32),
            changesLabel.widthAnchor.constraint(equalToConstant: 80),
            changesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func configureLastPrice() {
        addSubview(lastPrice)
        lastPrice.translatesAutoresizingMaskIntoConstraints = false
        lastPrice.textColor = .white
        lastPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lastPrice.text = "52.073,37"
        
        NSLayoutConstraint.activate([
            lastPrice.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            lastPrice.trailingAnchor.constraint(equalTo: changesLabel.leadingAnchor, constant: -20),
        ])
    }
    
    func configureLastPriceInUnit() {
        addSubview(lastPriceInUnit)
        lastPriceInUnit.translatesAutoresizingMaskIntoConstraints = false
        lastPriceInUnit.textColor = .gray
        lastPriceInUnit.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lastPriceInUnit.text = "$52.073,37"
        
        NSLayoutConstraint.activate([
            lastPriceInUnit.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            lastPriceInUnit.trailingAnchor.constraint(equalTo: changesLabel.leadingAnchor, constant: -20),
        ])
    }
}
