//
//  StockDataResponse.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Mapper

class StockDataResponse: AbstractResponse {
    
    public var result: StockData?
    
    required init(map: Mapper) throws {
        try super.init(map: map)
        mapping(map: map)
    }
    
    // Conforms to Mappable
    override func mapping(map: Mapper){
        self.result = map.optionalFrom("Meta Data")
    }
    
    // Converts all variables to a readable string for debug
    override func prettyPrint() -> String {
        return "StockDataResponse:"
    }
}
