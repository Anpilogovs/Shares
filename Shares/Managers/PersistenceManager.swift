//
//  PersistenceManager.swift
//  Shares
//
//  Created by Сергей Анпилогов on 26.10.2023.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "haOnboarded"
        static let watchListKey = "watchlist"
    }
    
    
    private init() {}
    
    //MARK: - Public
    var watchlist: [String] {
        if !hasOnboarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setUpDefaults()
        }
        return userDefaults.stringArray(forKey: Constants.watchListKey) ?? []
    }
    public func addToWatchlist() {
        
    }
    
    public func removeFromWatchlist() {
        
    }
    
    
    //MARK: - Private
    
    private var hasOnboarded: Bool {
        return userDefaults.bool(forKey: Constants.onboardedKey)
    }
    
    private func setUpDefaults() {
        let map: [String: String] = [
            "AAPL" : "Apple Inc",
            "MSFT" : "Microsoft Corporation",
            "SNAP" : "Snap Inc",
            "GOOG" : "Alphabet",
            "AMZN" : "Amazon.com, Inc.",
            "WORK" : "Slack Technologies",
            "FB"   : "Facebook Inch",
            "NVDA" : "Nvidia Inch",
            "NKE"  : "Nike",
            "PINS" : "Pinterest Inc."
        ]
        
        let symbol = map.keys.map { $0 }
        userDefaults.set(symbol, forKey: Constants.watchListKey)
        
        for (symbol, name) in map {
            userDefaults.set(name, forKey: symbol )
        }
    }
}
