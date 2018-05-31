//
//  SymbolAPI.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/25/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class SymbolAPI {
    
    static func getAllSymbols() -> [Symbol] {
        return getMockData()
    }
    
    fileprivate static func getMockData() -> [Symbol] {
        var data: [Symbol] = []
        data.append(Symbol(id: "AMZN", name: "Amazon.com, Inc.", logo:"AMZN"))
        data.append(Symbol(id: "AAPL", name: "Apple Inc.", logo:"AAPL"))
        data.append(Symbol(id: "FB", name: "Facebook, Inc", logo:"FB"))
        data.append(Symbol(id: "IBM", name: "IBM Common Stock", logo:"IBM"))
        data.append(Symbol(id: "MSFT", name: "Microsoft Corporation", logo:"MSFT"))
        data.append(Symbol(id: "ATVI", name: "Activision Blizzard, Inc.", logo:"ATVI"))
        data.append(Symbol(id: "HPQ", name: "HP Inc", logo:"HPQ"))
        data.append(Symbol(id: "DVMT", name: "Dell Technologies Inc", logo:"DVMT"))
        data.append(Symbol(id: "ACER", name: "Acer Therapeutics Inc", logo:"ACER"))
        data.append(Symbol(id: "EA", name: "Electronic Arts Inc.", logo:"EA"))
        data.append(Symbol(id: "MSFT", name: "Microsoft Corporation", logo:"MSFT"))
        data.append(Symbol(id: "GOOGL", name: "Alphabet Inc Class A", logo:"GOOGL"))
        data.append(Symbol(id: "ORCL", name: "Oracle Corporation", logo:"ORCL"))
        data.append(Symbol(id: "UBI", name: "Ubisoft Entertainment SA", logo:"UBI"))
        data.append(Symbol(id: "WMT", name: "Walmart Inc", logo:"WMT"))
        data.append(Symbol(id: "ACER", name: "Acer Therapeutics Inc", logo:"ACER"))
        data.append(Symbol(id: "HPQ", name: "HP Inc", logo:"HPQ"))
        data.append(Symbol(id: "IBM", name: "IBM Common Stock", logo:"IBM"))

        return data
    }
}
