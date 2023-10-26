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
        
    }
    
    
    private init() {}
    
    //MARK: - Public
    var watchlist: [String] {
        return []
    }
    public func addToWatchlist() {
        
    }
    
    public func removeFromWatchlist() {
        
    }
    
    
    //MARK: - Private
    
    private var hasOnboarded: Bool {
        return false
    }
}
