//
//  APICaller.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    
    private struct Constants {
        static let apiKey = "c3c6me2ad3iefuuilms0"
//        static let apiKey = "ckt7tt9r01qvc3s6vk20ckt7tt9r01qvc3s6vk2g"

        static let sandboxApiKey = "sandbox_c3c6me2ad3iefuuilmsg"
        static let weebhook = "ckt7tt9r01qvc3s6vk3g"
        static let baseUrl = "https://finnhub.io/api/v1/"
    }
    
    private init() {}
    
    //MARK: Public
    public func search(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
       
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
           return
        }

        request(url: url(for: .search, queryParams: ["q": query]), expecting: SearchResponse.self, completion: completion)
        
            return
    }
    
    //get stock info
    
    
    // search stocks
    
    //MARK: - Private
    
    private enum Endpoint: String {
        case search = "search"
    }
    
    private enum APIError: Error  {
        case noDataReturned
        case invalidUrl
    }
    
    private func url(for endpoint: Endpoint, queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        //Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        
        //Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
       
        
        //Convert query items to suffix string
        
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")"}.joined(separator:"&")

        print("\n\(urlString)\n")
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            //invalid URL
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
