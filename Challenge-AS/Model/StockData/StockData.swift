//
//  StockData.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Mapper

public class StockData: Mappable {
    
    private struct SerializationKeys {
        static let information = "1. Information"
        static let symbol = "2. Symbol"
        static let lastRefreshed = "3. Last Refreshed"
        static let timeZone = "4. Time Zone"
    }
    
    public var information: String?
    public var symbol: String?
    public var lastRefreshed: String?
    public var timeZone: String?
    
    required public init(map: Mapper) throws {
        information = map.optionalFrom(SerializationKeys.information)
        symbol = map.optionalFrom(SerializationKeys.symbol)
        lastRefreshed = map.optionalFrom(SerializationKeys.lastRefreshed)
        timeZone = map.optionalFrom(SerializationKeys.timeZone)
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.information = aDecoder.decodeObject(forKey: SerializationKeys.information) as? String
        self.symbol = aDecoder.decodeObject(forKey: SerializationKeys.symbol) as? String
        self.lastRefreshed = aDecoder.decodeObject(forKey: SerializationKeys.lastRefreshed) as? String
        self.timeZone = aDecoder.decodeObject(forKey: SerializationKeys.timeZone) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(information, forKey: SerializationKeys.information)
        aCoder.encode(symbol, forKey: SerializationKeys.symbol)
        aCoder.encode(lastRefreshed, forKey: SerializationKeys.lastRefreshed)
        aCoder.encode(timeZone, forKey: SerializationKeys.timeZone)
    }
}
