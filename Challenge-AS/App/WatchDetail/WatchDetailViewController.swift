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
    @IBOutlet private weak var messageLabel: UILabel!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHeaderData()
        loadStockData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //MARK: Actions
    
    @IBAction func timeSeriesSegmentedControlChanged(_ sender: Any) {
        self.removeCurrentViewController()
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
        
        self.messageLabel.isHidden = true;
        LoadingView.shared.showLoading()
        
        let symbol = self.symbol?.id
        let interval = AlphaVantage.Interval.m60.rawValue
        
        StockAPI.getStockTimeSeriesIntraday(symbol: symbol!, interval: interval) { (result) in
            switch result {
            case .success(let stock):
                self.prepareData(stock: stock)
                LoadingView.shared.dismissLoading()
            case .failure(let error):
                //TODO: Localization
                let message = "An unexpected error has occurred. Try again later."
                self.showAlert(message: message)
                self.messageLabel.text = message
                self.messageLabel.isHidden = false
                LoadingView.shared.dismissLoading()
            }
        }
    }
    
    fileprivate func prepareData(stock: StockMetaData) {
        let array = Array(stock.item)
        if array.count > 0 {
            
            var chartItems: [ChartItem] = []
            
            var i = array.count
            for item in array {
                i=i-1
                let newValue = ChartValue(number: i, text: item.value.close, item: item.value)
                let newItem = ChartItem(date: item.key, value: newValue)
                chartItems.append(newItem)
                
                print("Item: \(i) => Key: \(item.key) => Value: \(item.value.close)")
            }
            
            //Sorted all items by date for future filter by one day
            var itemsSortedByDate = chartItems
            itemsSortedByDate.sort {
                return $0.date > $1.date
            }
            
            let f = itemsSortedByDate.first
            var oneDayString = ""
            if let date = f?.date {
                oneDayString = Utils.getDateFromDate(text: date)
            } else {
                //TODO: Localization
                let message = "An unexpected error has occurred. Try again later."
                self.showAlert(message: message)
                self.messageLabel.text = message
                self.messageLabel.isHidden = false
                return
            }
            
            //Items filtered
            var itemsFiltered = chartItems.filter { $0.date.contains(oneDayString)  }
            itemsFiltered.sort {
                return $0.date < $1.date
            }
            
            //Items filtered Sorted (Close value)
            var itemsSortedFiltered = itemsSortedByDate.filter { $0.date.contains(oneDayString)  }
            itemsSortedFiltered.sort {
                return $0.value.item.close < $1.value.item.close
            }
            
            var newNumber: Int = itemsSortedFiltered.count
            var newChartItemsFiltered: [ChartItem] = []
            for itemBase in itemsFiltered {
                
                newNumber=newNumber-1
                
                let val = String(format: "%.02f", (itemBase.value.text as NSString).doubleValue)
                let dat = Utils.getTimeFromDate(text: itemBase.date)
                
                let newValue = ChartValue(number: newNumber, text: val, item: itemBase.value.item)
                let newItem = ChartItem(date: dat, value: newValue)
                newChartItemsFiltered.append(newItem)
            }
            
            newNumber = itemsSortedFiltered.count
            var newChartItemsSorteredFiltered: [ChartItem] = []
            for itemBase in itemsSortedFiltered {
                newNumber=newNumber-1
                
                let val = String(format: "%.02f", (itemBase.value.text as NSString).doubleValue)
                let dat = Utils.getTimeFromDate(text: itemBase.date)
                
                let newValue = ChartValue(number: newNumber, text: val, item: itemBase.value.item)
                let newItem = ChartItem(date: dat , value: newValue)
                newChartItemsSorteredFiltered.append(newItem)
            }
            
            if (newChartItemsFiltered.count > 0) {
                self.showChartViewController(controller: CubicLinesViewController(), items: newChartItemsFiltered, itemsSorted: newChartItemsSorteredFiltered)
                
                self.closeValueLabel.text = String(format: "%.02f", (f?.value.item.close as! NSString).doubleValue)
                self.dataView.setup(item: (f?.value.item)!)
                
            } else {
                //TODO: Localization
                let message = "An unexpected error has occurred. Try again later."
                self.showAlert(message: message)
                self.messageLabel.text = message
                self.messageLabel.isHidden = false
            }
        } else {
            //TODO: Localization
            let message = "An unexpected error has occurred. Try again later."
            self.showAlert(message: message)
            self.messageLabel.text = message
            self.messageLabel.isHidden = false
        }
    }
    
    fileprivate func removeCurrentViewController() {
        if let currentViewController = currentViewController {
            currentViewController.removeFromParentViewController()
            currentViewController.view.removeFromSuperview()
        }
        self.dataView.clear()
    }
    
    fileprivate func showChartViewController(controller: ChartBaseViewController, items: [ChartItem], itemsSorted: [ChartItem]) {
        
        self.removeCurrentViewController()
        controller.chartItems = items
        controller.chartItemsSorted = itemsSorted
        
        let chartFrame = CGRect(x: 0, y: 0, width: 365, height: 253)
        controller.chartFrame = chartFrame
        
        addChildViewController(controller)
        chartView.addSubview(controller.view)
        currentViewController = controller
    }
}
