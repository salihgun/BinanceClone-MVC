//
//  SortView.swift
//  BinanceClone
//
//  Created by Salih Gün on 10.03.2024.
//

import UIKit

enum SortType {
    case name,vol,lastPrice,changes,none
}
enum SortOrder {
    case asc,desc
}

protocol SortViewDelegate: AnyObject {
    func onNameClicked(order: SortOrder)
    func onVolumeClicked(order: SortOrder)
    func onLastPriceClicked(order: SortOrder)
    func onChangesClicked(order: SortOrder)
}

class SortView: UIView {

    let nameSortView = SortParameterView(text: "Name")
    let HrChange = SortParameterView(text: "24h chg%")
    let lastPriceView = SortParameterView(text: "Last Price")
    let volumeView = SortParameterView(text: "Vol")
    let seperatorMark = UILabel()
    
    var selectedParameter: SortType = .none
    var selectedOrder: SortOrder = .desc
    
    weak var delegate: SortViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureNameParameter()
        configureSeperator()
        configureChangeParameter()
        configureLastPrice()
        configureVolume()
        configureTouchable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
    }
    
    func configureNameParameter() {
        addSubview(nameSortView)
        nameSortView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameSortView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameSortView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameSortView.heightAnchor.constraint(equalToConstant: 30),
            nameSortView.widthAnchor.constraint(lessThanOrEqualToConstant: 90)
        ])
    }
    
    func configureChangeParameter() {
        addSubview(HrChange)
        HrChange.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            HrChange.trailingAnchor.constraint(equalTo: trailingAnchor),
            HrChange.centerYAnchor.constraint(equalTo: centerYAnchor),
            HrChange.heightAnchor.constraint(equalToConstant: 30),
            HrChange.widthAnchor.constraint(lessThanOrEqualToConstant: 90)
        ])
    }
    
    func configureLastPrice() {
        addSubview(lastPriceView)
        lastPriceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastPriceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -98),
            lastPriceView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lastPriceView.heightAnchor.constraint(equalToConstant: 30),
            lastPriceView.widthAnchor.constraint(lessThanOrEqualToConstant: 90)
        ])
    }
    
    func configureVolume() {
        addSubview(volumeView)
        volumeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            volumeView.leadingAnchor.constraint(equalTo: seperatorMark.trailingAnchor, constant: 2),
            volumeView.centerYAnchor.constraint(equalTo: centerYAnchor),
            volumeView.heightAnchor.constraint(equalToConstant: 30),
            volumeView.widthAnchor.constraint(lessThanOrEqualToConstant: 90)
        ])
    }
    
    func configureSeperator() {
        addSubview(seperatorMark)
        seperatorMark.translatesAutoresizingMaskIntoConstraints = false
        seperatorMark.textColor = .gray
        seperatorMark.text = "/"
        
        NSLayoutConstraint.activate([
            seperatorMark.leadingAnchor.constraint(equalTo: nameSortView.trailingAnchor),
            seperatorMark.centerYAnchor.constraint(equalTo: centerYAnchor),
            seperatorMark.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureTouchable() {
        let nameTapGesture = UITapGestureRecognizer(target: self, action: #selector(onNameClicked))
        nameSortView.addGestureRecognizer(nameTapGesture)
        let volTapGesture = UITapGestureRecognizer(target: self, action: #selector(onVolumeClicked))
        volumeView.addGestureRecognizer(volTapGesture)
        let lastPriceTapGesture = UITapGestureRecognizer(target: self, action: #selector(onLastPriceClicked))
        lastPriceView.addGestureRecognizer(lastPriceTapGesture)
        let changesGesture = UITapGestureRecognizer(target: self, action: #selector(onChangesClicked))
        HrChange.addGestureRecognizer(changesGesture)
    }
    
    func onSelectParameter(type: SortType,param: SortType, to view: SortParameterView) {
        if selectedParameter == param {
            selectedOrder = selectedOrder == .asc ? .desc : .asc
            view.upperChevronIcon.tintColor = selectedOrder == .asc ? .white : .gray
            view.downChevronIcon.tintColor = selectedOrder == .asc ? .gray : .white
        } else {
            selectedOrder = .desc
            let views = [nameSortView,volumeView,lastPriceView,HrChange]
            for theView in views {
                theView.downChevronIcon.tintColor = theView == view ? .white : .gray
                theView.upperChevronIcon.tintColor =  .gray
            }
        }
        selectedParameter = type
    }
    
    @objc func onNameClicked() {
        onSelectParameter(type: .name, param: .name, to: nameSortView)
        delegate?.onNameClicked(order: selectedOrder)
    }
    @objc func onVolumeClicked() {
        onSelectParameter(type: .vol ,param: .vol, to: volumeView)
        delegate?.onVolumeClicked(order: selectedOrder)
    }
    @objc func onLastPriceClicked() {
        onSelectParameter(type: .lastPrice ,param: .lastPrice, to: lastPriceView)
        delegate?.onLastPriceClicked(order: selectedOrder)
    }
    @objc func onChangesClicked() {
        onSelectParameter(type: .changes, param: .changes, to: HrChange)
        delegate?.onChangesClicked(order: selectedOrder)
    }
}
