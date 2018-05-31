//
//  WatchDetailDataView.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class WatchDetailDataView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!

    func clear() {
        closeLabel.text = ""
        openLabel.text = ""
        highLabel.text = ""
        lowLabel.text = ""
        volumeLabel.text = ""
    }
    
    func setup(item: StockSerieItem) {
        closeLabel.text = String(format: "%.02f", (item.close as NSString).doubleValue)
        openLabel.text = String(format: "%.02f", (item.open as NSString).doubleValue)
        highLabel.text = String(format: "%.02f", (item.high as NSString).doubleValue)
        lowLabel.text = String(format: "%.02f", (item.low as NSString).doubleValue)
        volumeLabel.text = item.volume
    }
}
