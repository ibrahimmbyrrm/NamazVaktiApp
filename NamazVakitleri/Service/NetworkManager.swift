//
//  NetworkManager.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

enum HTTPErrors: String,Error{
    case invalidURL
    case invalidResponse
    case invalidData
    case parsingError
}

protocol NetworkInterface {
    func fetchData<T : Decodable>(type : EndPointItems<T>,completion : @escaping (Result<T,HTTPErrors>)->Void)
}


final class NetworkManager : NetworkInterface {
    
    func fetchData<T>(type: EndPointItems<T>, completion: @escaping (Result<T, HTTPErrors>) -> Void) where T : Decodable {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.method.rawValue
        print(urlRequest)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if (response as? HTTPURLResponse)?.statusCode != 200 {
                    completion(.failure(.invalidResponse))
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                self.parseModel(data: data) { result in
                    completion(result)
                }
            }
        }.resume()
        
    }
    
    private func parseModel<T>(data: Data,completion : @escaping (Result<T,HTTPErrors>)->Void) where T : Decodable {
        do {
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(T.self, from: data)
            completion(.success(decodedModel))
        }catch {
            completion(.failure(.parsingError))
        }
    }
}
