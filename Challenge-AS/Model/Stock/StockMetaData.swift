//
//  StockMetaData.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

struct StockMetaData: Codable {
    let info: StockInfo
    let item: [String:StockSerieItem]
}

extension StockMetaData {
    enum CodingKeys: String, CodingKey {
        case info = "Meta Data"
        case item = "Time Series (60min)"
    }
}
