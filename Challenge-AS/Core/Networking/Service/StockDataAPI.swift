//
//  StockDataAPI.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Alamofire

class StockDataAPI {
    
    public static let sharedInstance = StockDataAPI()
    
    private init() {}
    
    func getTimeSeriesWeekly(request: StockDataRequest, success: @escaping (_ responseObject: StockDataResponse?) -> (), errorResponse: @escaping (ASError?) -> ()) {
        
        AlamofireNetworking.sharedInstance.doGet(requestObject: request, encoding: URLEncoding.default, success: { (response: StockDataResponse?, responseList: [StockDataResponse]?, allCookies: [HTTPCookie]?, _ allHeader: [AnyHashable: Any]?) in
            success(response)
        }, failure: { (error: ASError?) in
            errorResponse(error)
        })
    }
}
