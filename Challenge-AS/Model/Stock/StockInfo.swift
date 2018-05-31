//
//  Stock.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

struct StockInfo: Codable {
    let information: String!
    let symbol: String!
    let lastRefreshed: String!
    let interval: String!
    let outputSize: String!
    let timeZone: String!
}

extension StockInfo {
    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
    }
}
