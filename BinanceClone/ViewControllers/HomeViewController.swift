//
//  HomeViewController.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import UIKit

class HomeViewController: UIViewController {
    let customSearchBar = CustomSearchBar()
    let tableView = UITableView()
    let sortView = SortView()
    
    var cryptoList: [Crypto] = []
    var filteredCryptoList : [Crypto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCustomSearchBar()
        configureSortView()
        configureTableView()
        getPairs()
    }
    
    func configureVC() {
        view.backgroundColor = Colors.primaryColor
    }
    
    func configureCustomSearchBar() {
        view.addSubview(customSearchBar)
        customSearchBar.customDelegate = self
        NSLayoutConstraint.activate([
            customSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            customSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            customSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            customSearchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.reuseIdentifier)
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        tableView.separatorStyle  = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: sortView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureSortView() {
        view.addSubview(sortView)
        sortView.translatesAutoresizingMaskIntoConstraints = false
        sortView.backgroundColor = .clear
        sortView.delegate = self
        
        NSLayoutConstraint.activate([
            sortView.topAnchor.constraint(equalTo: customSearchBar.bottomAnchor,constant: 20),
            sortView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            sortView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            sortView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func getPairs() {
        NetworkManager.shared.getPairs { result in
            switch result {
            case .success(let res):
                self.cryptoList = res.data
                self.filteredCryptoList = res.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCell.reuseIdentifier, for: indexPath) as! CryptoCell
        let crypto = filteredCryptoList[indexPath.row]
        cell.set(currency: crypto)
        return cell
    }
}

extension HomeViewController : CustomSearchBarDelegate {
    func didSearchTextChanged(text: String) {
        filteredCryptoList = text.isEmpty ? cryptoList : cryptoList.filter { $0.symbol.lowercased().contains(text.lowercased()) }
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}

extension HomeViewController: SortViewDelegate {
    
    func applySort<T:Comparable>(order: SortOrder, keyPath: KeyPath<Crypto,T>) {
        switch order {
          case .asc:
            filteredCryptoList.sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
          case .desc:
            filteredCryptoList.sort { $0[keyPath: keyPath] > $1[keyPath: keyPath] }
          }
        tableView.reloadData()
    }
    
    func onNameClicked(order: SortOrder) {
        applySort(order: order, keyPath: \.name)
    }
    
    func onVolumeClicked(order: SortOrder) {
        applySort(order: order, keyPath: \.volume24)
    }
    
    func onLastPriceClicked(order: SortOrder) {
        applySort(order: order, keyPath: \.priceUsd)
    }
    
    func onChangesClicked(order: SortOrder) {
        applySort(order: order, keyPath: \.percentChange24H)
    }
}
