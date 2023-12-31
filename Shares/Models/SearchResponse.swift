//
//  SearchResponse.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import Foundation


struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
