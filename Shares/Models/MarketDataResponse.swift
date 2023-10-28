//
//  MarketDataResponse.swift
//  Shares
//
//  Created by Сергей Анпилогов on 28.10.2023.
//

import Foundation

struct MarketDataResponse: Codable {
    let open: [Double]
    let close: [Double]
    let hight: [Double]
    let low: [Double]
    let status: String
    let timestamps: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case open = "o"
        case low = "l"
        case close = "c"
        case hight = "h"
        case status = "s"
        case timestamps = "t"
    }
    
    var candleStick: [CandleStick] {
        var result = [CandleStick]()
        
        for index in 0..<open.count {
            result.append(
                .init(date: Date(timeIntervalSince1970: timestamps[index]),
                      hight: hight[index],
                      low: low[index],
                      open: open[index],
                      close: close[index]))
        }
        let sortedData = result.sorted { $0.date < $1.date }
        print(sortedData[0])
        return sortedData
    }
}
struct CandleStick {
    let date: Date
    let hight: Double
    let low: Double
    let open: Double
    let close: Double
}
