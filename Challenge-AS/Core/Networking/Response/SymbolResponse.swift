//
//  SymbolDataResponse.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/25/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class SymbolResponse {
    
    public var result: [Symbol]?
    
    init() {
        self.result = getMockData()
    }
    
    public func getMockData() -> [Symbol] {
        var data: [Symbol] = []
        data.append(Symbol(id: "AMZN", name: "Amazon"))
        data.append(Symbol(id: "AAPL", name: "Apple Inc."))
        data.append(Symbol(id: "FB", name: "Facebook"))
        data.append(Symbol(id: "IBM", name: "IBM"))
        data.append(Symbol(id: "MSFT", name: "Microsoft"))
        data.append(Symbol(id: "ATVI", name: "Activision"))
        data.append(Symbol(id: "HPQ", name: "HP"))
        data.append(Symbol(id: "DVMT", name: "DELL"))
        data.append(Symbol(id: "ACER", name: "Acer"))
        data.append(Symbol(id: "EA", name: "Eletronic Arts"))
        data.append(Symbol(id: "TGT", name: "Amazon"))
        data.append(Symbol(id: "GOOGL", name: "Google"))
        data.append(Symbol(id: "ORCL", name: "Oracle"))
        data.append(Symbol(id: "SAP", name: "SAP"))
        
        return data
    }
}
