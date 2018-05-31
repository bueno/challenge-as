//
//  StockSerieItem.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

struct StockSerieItem: Codable {
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
}

extension StockSerieItem {
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}
