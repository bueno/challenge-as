//
//  StockData.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Mapper

/*
 Meta Data: {
 "1. Information": "Weekly Prices (open, high, low, close) and Volumes",
 "2. Symbol": "MSFT",
 "3. Last Refreshed": "2018-05-23",
 "4. Time Zone": "US/Eastern"
 
 Weekly Time Series: {
 2018-05-23: {
 1. open: "97.0000",
 2. high: "98.0100",
 3. low: "96.3200",
 4. close: "97.8800",
 5. volume: "28718653"
 },
 */

public class StockData: Mappable {
    
    let informationKey = "1. Information"
    let symbolKey = "2. Symbol"
    let lastRefreshedKey = "3. Last Refreshed"
    let timeZoneKey = "4. Time Zone"
    
    public var information: String? = ""
    var symbol: String? = ""
    var lastRefreshed: String? = ""
    var timeZone: String? = ""

    //var stockDataSerie: StockDataSerie?
    
    public required init(map: Mapper) throws {
        information = map.optionalFrom(informationKey)
        symbol = map.optionalFrom(symbolKey)
        lastRefreshed = map.optionalFrom(lastRefreshedKey)
        timeZone = map.optionalFrom(timeZoneKey)
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.information = aDecoder.decodeObject(forKey: informationKey) as? String
        self.symbol = aDecoder.decodeObject(forKey: symbolKey) as? String
        self.lastRefreshed = aDecoder.decodeObject(forKey: lastRefreshedKey) as? String
        self.timeZone = aDecoder.decodeObject(forKey: timeZoneKey) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(information, forKey: informationKey)
        aCoder.encode(symbol, forKey: symbolKey)
        aCoder.encode(lastRefreshed, forKey: lastRefreshedKey)
        aCoder.encode(timeZone, forKey: timeZoneKey)
    }
}
