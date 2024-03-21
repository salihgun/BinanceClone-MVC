//
//  CustomSearchBar.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import UIKit

protocol CustomSearchBarDelegate: AnyObject{
    func didSearchTextChanged(text: String)
}


class CustomSearchBar: UIView {
    let textfield = CustomTextField(placeholder: "Search Coin Pairs")
    let searchView = UIView()
    
    let searchIcon = UIImageView()
    let ellipsisIcon = UIImageView()

    weak var customDelegate: CustomSearchBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureSearchView()
        configureEllipsisIcon()
        configureIcon()
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    func configureSearchView() {
        addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = Colors.primaryBackgroundColor
        searchView.layer.cornerRadius = 10
        searchView.layer.cornerCurve = .continuous
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topAnchor),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureIcon() {
        searchView.addSubview(searchIcon)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.image = Icons.search
        searchIcon.tintColor = .gray
        
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIcon.heightAnchor.constraint(equalToConstant: 15),
            searchIcon.widthAnchor.constraint(equalToConstant: 15),
            searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func configureTextField() {
        searchView.addSubview(textfield)
        textfield.customDelegate = self
        NSLayoutConstraint.activate([
            textfield.centerYAnchor.constraint(equalTo: centerYAnchor),
            textfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            textfield.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 10),
            textfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureEllipsisIcon() {
        addSubview(ellipsisIcon)
        ellipsisIcon.translatesAutoresizingMaskIntoConstraints = false
        ellipsisIcon.image = Icons.ellipsis
        ellipsisIcon.tintColor = .white
        NSLayoutConstraint.activate([
            ellipsisIcon.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            ellipsisIcon.heightAnchor.constraint(equalToConstant: 20),
            ellipsisIcon.widthAnchor.constraint(equalToConstant: 20),
            ellipsisIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
            ellipsisIcon.leadingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: 6)
        ])
    }
}

extension CustomSearchBar: CustomTextFieldDelegate {
    func didSearchTextChanged(text: String) {
        customDelegate.didSearchTextChanged(text: text)
    }
}

