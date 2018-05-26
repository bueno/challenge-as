//
//  ChartItem.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

struct ChartItem {
    let name: String
    let value: ChartValue
    
    init(name: String, value: ChartValue) {
        self.name = name
        self.value = value
    }
}
