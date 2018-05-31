//
//  ChartValue.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

struct ChartValue {
    var number: Int
    var text: String
    var item: StockSerieItem!
    
    init(number: Int, text: String, item: StockSerieItem) {
        self.number = number
        self.text = text
        self.item = item
    }
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
