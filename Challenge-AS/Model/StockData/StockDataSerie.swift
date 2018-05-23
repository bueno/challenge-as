//
//  StockDataSerie.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Mapper

public final class StockDataSerie: Mappable {
    
    var name: String? = ""
    var value: String? = ""

    public required init(map: Mapper) throws {
        name = map.optionalFrom("name")
        value = map.optionalFrom("value")
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.value = aDecoder.decodeObject(forKey: "value") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(value, forKey: "value")
    }
}
