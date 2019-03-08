//
//  APIClient.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Alamofire

class StockAPI {
    
    static func getStockTimeSeriesDaily(symbol: String, completion: @escaping ((Result<StockDailyMetaData>) -> Void)) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: Constants.AlphaVantage.Functions.timeSeriesDaily),
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_DAILY: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        AF.request(url).responseDecodable { (response : DataResponse<StockDailyMetaData>) in
            completion(response.result)
        }
    }
    
    static func getStockTimeSeriesWeekly(symbol: String, completion: @escaping ((Result<StockWeeklyMetaData>) -> Void)) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: Constants.AlphaVantage.Functions.timeSeriesWeekly),
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_WEEKLY: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        AF.request(url).responseDecodable { (response : DataResponse<StockWeeklyMetaData>) in
            completion(response.result)
        }
    }
    
    static func getStockTimeSeriesMonthly(symbol: String, completion: @escaping ((Result<StockMonthlyMetaData>) -> Void)) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = APISettings.sharedInstance.environment.scheme
        urlComponents.host = APISettings.sharedInstance.environment.host
        urlComponents.path = APISettings.sharedInstance.environment.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: APISettings.sharedInstance.environment.APIKey),
            URLQueryItem(name: "function", value: Constants.AlphaVantage.Functions.timeSeriesMonthly),
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponents.url else {
            print("TIME_SERIES_MONTHLY: bad url!")
            completion(.failure("Error" as! Error))
            return
        }
        
        AF.request(url).responseDecodable { (response : DataResponse<StockMonthlyMetaData>) in
            completion(response.result)
        }
    }
}
