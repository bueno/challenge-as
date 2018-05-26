//
//  StockDataRequest.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class StockDataRequest : AbstractRequest {
    
    var symbol: String?
    
    init(symbol: String?)
    {
        self.symbol = symbol
    }
    
    private var endPoint: String {
        return String(format: Constants.WebService.EndPoint.StockData.Get_TIME_SERIES_WEEKLY, APISettings.sharedInstance.environment.APIKey, symbol!)
    }
    
    override func urlPath() -> String {
        return self.endPoint
    }
    
    override func toDictionary() -> [String : Any] {
        return [:]
    }
    
    override func prettyPrint() -> String {
        return "StockDataRequest:\n"
    }
}
