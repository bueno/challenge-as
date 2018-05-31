//
//  ChartItem.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

struct ChartItem {
    let date: String
    let value: ChartValue
    
    init(date: String, value: ChartValue) {
        self.date = date
        self.value = value
    }
}
