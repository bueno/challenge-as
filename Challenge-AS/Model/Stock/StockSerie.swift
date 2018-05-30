//
//  StockSerie.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

struct StockSerie: Codable {
    let item: StockSerieItem
}

extension StockSerie {
    enum CodingKeys: String, CodingKey {
        case item = "Weekly Time Series"
    }
}

