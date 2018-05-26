//
//  WatchDetailViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/24/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class WatchDetailViewController: BaseViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var dataView: WatchDetailDataView!
    @IBOutlet private weak var chartView: UIView!
    @IBOutlet private weak var symbolNameLabel: UILabel!
    @IBOutlet private weak var closeValueLabel: UILabel!
    @IBOutlet private weak var timeSeriesSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var notifymeButton: UIButton!
    
    
    //MARK: Private Properties

    private var notifymeIsEnabled: Bool = false
    var symbol: Symbol?
    
    lazy private(set) var chartFrame: CGRect! = {
        CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.height - 80)
    }()
    private var currentViewController: UIViewController?

    
    //MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        //TODO:
//        self.dataView.addBorder(toSide: .Top, withColor: UIColor.black, andThickness: 1.0)
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black
//        self.navigationController?.navigationItem.tit = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHeaderData()
        loadStockData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK: Actions
    
    @IBAction func timeSeriesSegmentedControlChanged(_ sender: Any) {
        loadStockData()
    }
    
    @IBAction func notifymeButtonPressed(_ sender: Any) {
        if (notifymeIsEnabled) {
            notifymeButton.setTitle("NOTIFY ME", for: UIControlState.normal)
            notifymeIsEnabled = false
        } else {
            notifymeButton.setTitle("DISABLE NOTIFY ME", for: UIControlState.normal)
            notifymeIsEnabled = true
        }
    }
    
    
    //MARK: Private Methods
    
    private func loadHeaderData() {
        self.navigationItem.title = symbol?.id
        self.symbolNameLabel.text = symbol?.name
    }
    
    fileprivate func loadStockData() {
        
        LoadingView.shared.showLoading()
        
        let stockDataRequest = StockDataRequest(symbol: symbol?.id)
        
        StockDataAPI.sharedInstance.getTimeSeriesWeekly(request: stockDataRequest, success: { (success: StockDataResponse?) in
            guard let successResponse = success else {
                return
            }
            
            if let stockData = successResponse.result {
                
//                let data = successResponse.data {
//                    print
//                }
                
                let value4 = ChartValue(number: 4, text: "188.5800")
                let value3 = ChartValue(number: 2, text: "186.3100")
                let value2 = ChartValue(number: 3, text: "188.5900")
                let value1 = ChartValue(number: 1, text: "183.8300")
                let value0 = ChartValue(number: 0, text: "162.3200")
                
                let item0 = ChartItem(name: "18-05-25", value: value4)
                let item1 = ChartItem(name: "18-05-18", value: value3)
                let item2 = ChartItem(name: "18-05-11", value: value2)
                let item3 = ChartItem(name: "18-05-04", value: value1)
                let item4 = ChartItem(name: "18-04-27", value: value0)
                
                let chartItems = [item0, item1, item2, item3, item4]
                var chartItemsSorted = chartItems
                chartItemsSorted.sort {
                    return $0.value.number < $1.value.number
                }

                self.showChartViewController(controller: CubicLinesViewController(), items: chartItems, itemsSorted: chartItemsSorted)
                
                self.closeValueLabel.text = "187.20"
                
                self.dataView.setup(data: stockData)
                
                LoadingView.shared.dismissLoading()

                print(stockData)
            }
        }) { (error: ASError?) in
            LoadingView.shared.dismissLoading()
            print(error?.errorMessage as Any)
        }
    }
    
    fileprivate func showChartViewController(controller: ChartBaseViewController, items: [ChartItem], itemsSorted: [ChartItem]) {
        if let currentViewController = currentViewController {
            currentViewController.removeFromParentViewController()
            currentViewController.view.removeFromSuperview()
        }
        controller.chartItems = items
        controller.chartItemsSorted = itemsSorted
        
        let chartFrame = CGRect(x: 0, y: 0, width: 365, height: 253)
        controller.chartFrame = chartFrame
        
        addChildViewController(controller)
        chartView.addSubview(controller.view)
        currentViewController = controller
    }
}
