//
//  StockDataSerieItem.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Mapper

public final class StockDataSerieItem: Mappable {
    
    private struct SerializationKeys {
        static let open = "1. open"
        static let high = "2. high"
        static let low = "3. low"
        static let close = "4. close"
        static let volume = "5. volume"
    }

    var open: String? = ""
    var high: String? = ""
    var low: String? = ""
    var close: String? = ""
    var volume: String? = ""

    public required init(map: Mapper) throws {
        open = map.optionalFrom(SerializationKeys.open)
        high = map.optionalFrom(SerializationKeys.high)
        low = map.optionalFrom(SerializationKeys.low)
        close = map.optionalFrom(SerializationKeys.close)
        volume = map.optionalFrom(SerializationKeys.volume)
    }
}
