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
        
//        "Meta Data": {
//            "1. Information": "Intraday (60min) prices and volumes",
//            "2. Symbol": "AAPL",
//            "3. Last Refreshed": "2018-05-30 16:00:00",
//            "4. Interval": "60min",
//            "5. Output Size": "Compact",
//            "6. Time Zone": "US/Eastern"
//        },
//        "Time Series (60min)": {
        
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
    
    static func getStockTimeSeriesDaily(symbol: String, completion: @escaping ((Result<StockMetaData>) -> Void)) {
        
//        "Meta Data": {
//            "1. Information": "Daily Prices (open, high, low, close) and Volumes",
//            "2. Symbol": "AAPL",
//            "3. Last Refreshed": "2018-05-30",
//            "4. Output Size": "Compact",
//            "5. Time Zone": "US/Eastern"
//        },
//        "Time Series (Daily)": {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: AlphaVantage.Functions.timeSeriesDaily),
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_DAILY: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        Alamofire.request(url).responseJSONDecodable { (response : DataResponse<StockMetaData>) in
            completion(response.result)
        }
    }
    
    static func getStockTimeSeriesWeekly(symbol: String, completion: @escaping ((Result<StockMetaData>) -> Void)) {
        
//        "Meta Data": {
//            "1. Information": "Weekly Prices (open, high, low, close) and Volumes",
//            "2. Symbol": "AAPL",
//            "3. Last Refreshed": "2018-05-30",
//            "4. Time Zone": "US/Eastern"
//        },
//        "Weekly Time Series": {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: AlphaVantage.Functions.timeSeriesWeekly),
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_Weekly: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        Alamofire.request(url).responseJSONDecodable { (response : DataResponse<StockMetaData>) in
            completion(response.result)
        }
    }
    
    static func getStockTimeSeriesMonthly(symbol: String, completion: @escaping ((Result<StockMetaData>) -> Void)) {
        
//        "Meta Data": {
//            "1. Information": "Monthly Prices (open, high, low, close) and Volumes",
//            "2. Symbol": "AAPL",
//            "3. Last Refreshed": "2018-05-30",
//            "4. Time Zone": "US/Eastern"
//        },
//        "Monthly Time Series": {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: AlphaVantage.Functions.timeSeriesMonthly),
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_MONTHLY: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        Alamofire.request(url).responseJSONDecodable { (response : DataResponse<StockMetaData>) in
            completion(response.result)
        }
    }
}
