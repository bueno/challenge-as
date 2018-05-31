//
//  StockDailyMetaData.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/31/18.
//  Copyright © 2018 NxT. All rights reserved.
//

struct StockDailyMetaData: Codable {
    let info: StockInfo
    let item: [String:StockSerieItem]
}

extension StockDailyMetaData {
    enum CodingKeys: String, CodingKey {
        case info = "Meta Data"
        case item = "Time Series (Daily)"
    }
}
