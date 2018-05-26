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
    
    //var item: StockDataSerieItem? = nil
    var item: AnyObject!

    public required init(map: Mapper) throws {
        try item = map.from("", transformation: extractItem) as AnyObject as? StockDataSerieItem
    }
    
    private func extractItem(object: Any?) throws -> String {
        guard let item = object as? String else {
            throw MapperError.convertibleError(value: object, type: String.self)
        }
        return item
    }
}
