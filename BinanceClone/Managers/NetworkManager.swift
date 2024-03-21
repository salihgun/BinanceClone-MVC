//
//  NetworkManager.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    init() {}
    
    func getPairs(completion: @escaping(Result<CryptoResult, CryptoErrors>) -> Void) {
        guard let url = URL(string: Network.baseURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                completion(.failure(.networkError))
                return
            }
            do {
                let result = try JSONDecoder().decode(CryptoResult.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(.parsingError))
            }
        }
        task.resume()
    }
}
