//
//  ViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadStockData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadStockData() {
        
        let stockDataRequest = StockDataRequest(symbol: "MSFT")

        StockDataAPI.sharedInstance.getTimeSeriesWeekly(request: stockDataRequest, success: { (success: StockDataResponse?) in
            guard let successResponse = success else {
                return
            }

            if let data = successResponse.result {
                print(data)
            }
        }) { (error: ASError?) in
            print(error?.errorMessage as Any)
        }
    }
}

