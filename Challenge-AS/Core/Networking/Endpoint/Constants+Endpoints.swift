//
//  Constants+Endpoints.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

extension Constants {
    
    struct WebService {
        
        static let APIVersion = "/v1"
        
        struct EndPoint {
            
            enum UrlType {
                case Logged
                case Unlogged
            }
            
            struct BaseImageURL {
                static let baseImageURL = "http://avenuesecurities.com"
            }
            
            struct StockData {
                static let URLQuery = "query?function="
                
                //https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=demo
                static let Get_TIME_SERIES_INTRADAY = "TIME_SERIES_INTRADAY"
                
                //https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo
                static let Get_TIME_SERIES_DAILY = "TIME_SERIES_DAILY"
                
                //https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo
                static let Get_TIME_SERIES_WEEKLY = URLQuery + "TIME_SERIES_WEEKLY&apikey=%@&symbol=%@"
            }
        }
    }
}
