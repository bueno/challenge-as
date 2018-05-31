//
//  StockMonthlyMetaData.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/31/18.
//  Copyright © 2018 NxT. All rights reserved.
//

struct StockMonthlyMetaData: Codable {
    let info: StockInfo
    let item: [String:StockSerieItem]
}

extension StockMonthlyMetaData {
    enum CodingKeys: String, CodingKey {
        case info = "Meta Data"
        case item = "Monthly Time Series"
    }
}
