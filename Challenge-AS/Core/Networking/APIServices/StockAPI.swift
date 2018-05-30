//
//  APIClient.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Alamofire

struct AlphaVantage {

    /// Intervals allowed for intraday time series
    enum Interval: String {
        case m1 = "1min"
        case m5 = "5min"
        case m15 = "15min"
        case m30 = "30min"
        case m60 = "60min"
    }
    
    struct Functions {
        static let timeSeriesIntraday = "TIME_SERIES_INTRADAY"
        static let timeSeriesDaily = "TIME_SERIES_DAILY"
        static let timeSeriesWeekly = "TIME_SERIES_WEEKLY"
        static let timeSeriesMonthly = "TIME_SERIES_MONTHLY"
    }
}

class StockAPI {
    
    //TODO: Chamar outras funções
    static func getStockTimeSeriesIntraday(symbol: String, interval: String, completion: @escaping ((Result<StockMetaData>) -> Void)) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: AlphaVantage.Functions.timeSeriesIntraday),
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "interval", value: interval)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_INTRADAY: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        Alamofire.request(url).responseJSONDecodable { (response : DataResponse<StockMetaData>) in
            completion(response.result)
        }
    }
}
