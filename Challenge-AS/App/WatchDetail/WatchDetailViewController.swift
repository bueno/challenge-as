//
//  WatchDetailViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/24/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit
import Charts

class WatchDetailViewController: BaseViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var dataView: WatchDetailDataView!
    @IBOutlet private weak var lineChartView: LineChartView!
    @IBOutlet private weak var symbolNameLabel: UILabel!
    @IBOutlet private weak var closeValueLabel: UILabel!
    @IBOutlet private weak var timeSeriesSegmentedControl: UISegmentedControl!

    
    //MARK: Private Properties

    private var notifymeIsEnabled: Bool = false
    var symbol: Symbol?
    
    lazy private(set) var chartFrame: CGRect! = {
        CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.height - 80)
    }()

    weak var axisFormatDelegate: IAxisValueFormatter?

    
    //MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        axisFormatDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHeaderData()
        loadStockData(option: 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //MARK: Actions
    
    @IBAction func timeSeriesSegmentedControlChanged(_ sender: Any) {
        if Connectivity.isConnectedToInternet() {
            self.dataView.clear()

            let obj = sender as! UISegmentedControl
            loadStockData(option: obj.selectedSegmentIndex)
        } else {
            showAlert(message: Constants.MESSAGE.INTERNET_CONNECTION_IS_NOT_AVAILABLE)
        }
    }

    
    //MARK: Private Methods
    
    private func loadHeaderData() {
        self.navigationItem.title = symbol?.id
        self.symbolNameLabel.text = symbol?.name
    }
    
    fileprivate func loadStockData(option : Int) {
        
        LoadingView.shared.showLoading()
        
        switch option {
        case 0:
            self.loadDaily(symbol: (self.symbol?.id)!)
        case 1:
            self.loadWeekly(symbol: (self.symbol?.id)!)
        case 2:
            self.loadMonthly(symbol: (self.symbol?.id)!)
        default:
            self.loadDaily(symbol: (self.symbol?.id)!)
        }
    }
    
    fileprivate func loadDaily(symbol: String) {
        StockAPI.getStockTimeSeriesDaily(symbol: symbol) { (result) in
            switch result {
            case .success(let stock):
                self.updateChart(stock: stock.item)
                LoadingView.shared.dismissLoading()
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(message: Constants.MESSAGE.AN_UNEXPECTED_ERROR)
                LoadingView.shared.dismissLoading()
            }
        }
    }
    
    fileprivate func loadWeekly(symbol: String) {
        StockAPI.getStockTimeSeriesWeekly(symbol: symbol) { (result) in
            switch result {
            case .success(let stock):
                self.updateChart(stock: stock.item)
                LoadingView.shared.dismissLoading()
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(message: Constants.MESSAGE.AN_UNEXPECTED_ERROR)
                LoadingView.shared.dismissLoading()
            }
        }
    }
    
    fileprivate func loadMonthly(symbol: String) {
        StockAPI.getStockTimeSeriesMonthly(symbol: symbol) { (result) in
            switch result {
            case .success(let stock):
                self.updateChart(stock: stock.item)
                LoadingView.shared.dismissLoading()
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(message: Constants.MESSAGE.AN_UNEXPECTED_ERROR)
                LoadingView.shared.dismissLoading()
            }
        }
    }
    
    fileprivate func updateChart(stock: [String:StockSerieItem]) {
        let array = Array(stock)
        if array.count > 0 {
            
            let chartItems: [ChartItem] = formatChartItems(stock: stock)
            
            var lineChartEntry  = [ChartDataEntry]()
            for i in 0..<chartItems.count {
                
                let value: Double = Double(chartItems[i].value.text)!
                
                let date = Utils.convertStringToDate(date: chartItems[i].date, format: "yy-MM-dd")
                let timeIntervalForDate: TimeInterval = date.timeIntervalSince1970

                let entry = ChartDataEntry(x: Double(timeIntervalForDate), y: Double(value))
                lineChartEntry.append(entry)
            }
            
            let lineClose = LineChartDataSet(values: lineChartEntry, label: Constants.LABEL.CLOSE)
            lineClose.colors = [NSUIColor.blue]
            
            let data = LineChartData()
            data.addDataSet(lineClose)
            
            lineChartView.data = data
            lineChartView.chartDescription?.text = symbol?.id
            
            let xaxis = lineChartView.xAxis
            xaxis.valueFormatter = axisFormatDelegate
            
            let f = chartItems.last
            self.closeValueLabel.text = String(format: "%.02f", ((f?.value.item.close)! as NSString).doubleValue)
            self.dataView.setup(item: (f?.value.item)!)
            
        } else {
            self.showAlert(message: Constants.MESSAGE.AN_UNEXPECTED_ERROR)
        }
    }
    
    fileprivate func formatChartItems(stock: [String:StockSerieItem]) -> [ChartItem] {
        var chartItems: [ChartItem] = []
        let array = Array(stock)
        
        var arraySortedByDate = array
        arraySortedByDate.sort {
            return $0.key < $1.key
        }
        let arraySortedByDateFiltered = arraySortedByDate.suffix(5)
        
        var i = arraySortedByDateFiltered.count
        for item in arraySortedByDateFiltered {
            i=i-1
            let newValue = ChartValue(number: i, text: item.value.close, item: item.value)
            let newItem = ChartItem(date: item.key, value: newValue)
            chartItems.append(newItem)
        }
        return chartItems
    }
}

extension WatchDetailViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
