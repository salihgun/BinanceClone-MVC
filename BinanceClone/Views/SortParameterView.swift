//
//  SortParameterView.swift
//  BinanceClone
//
//  Created by Salih Gün on 10.03.2024.
//

import UIKit

class SortParameterView: UIStackView {
    let label = UILabel()
    
    let verticalStack = UIStackView()
    let upperChevronIcon = UIImageView()
    let downChevronIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLabel()
        configureVerticalStack()
        configureUpperChevron()
        configureDownChevron()
    }
    
    private func configure() {
        backgroundColor = .clear
        axis = .horizontal
    }
    
    convenience init(text: String) {
       self.init()
       label.text = text
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        addArrangedSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    func configureVerticalStack() {
        addArrangedSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.backgroundColor = .clear
        verticalStack.distribution = .equalSpacing
    }
    
    func configureUpperChevron() {
        verticalStack.addArrangedSubview(upperChevronIcon)
        upperChevronIcon.translatesAutoresizingMaskIntoConstraints = false
        upperChevronIcon.image = Icons.chevronUp
        upperChevronIcon.tintColor = .gray
        upperChevronIcon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            upperChevronIcon.leadingAnchor.constraint(equalTo: label.trailingAnchor,constant: 3),
            upperChevronIcon.heightAnchor.constraint(equalToConstant: 10),
            upperChevronIcon.widthAnchor.constraint(equalToConstant: 12),
            upperChevronIcon.topAnchor.constraint(equalTo: label.topAnchor, constant: 5)
        ])
    }
    
    func configureDownChevron() {
        verticalStack.addArrangedSubview(downChevronIcon)
        downChevronIcon.translatesAutoresizingMaskIntoConstraints = false
        downChevronIcon.image = Icons.chevronDown
        downChevronIcon.tintColor = .gray
        downChevronIcon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            downChevronIcon.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3),
            downChevronIcon.heightAnchor.constraint(equalToConstant: 10),
            downChevronIcon.widthAnchor.constraint(equalToConstant: 12),
            downChevronIcon.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: -5)
        ])
    }
}

