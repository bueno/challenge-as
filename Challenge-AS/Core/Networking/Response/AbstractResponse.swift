//
//  AbstractResponse.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Mapper

// A default 'abstract' class to any Response class
public class AbstractResponse: Mappable {
    
    init() {}
    
    // Conforms to Mappable
    required public init(map: Mapper) throws {}
    
    // Conforms to Mappable
    func mapping(map: Mapper){
        fatalError()
    }
    
    // Converts all variables to a readable string for debug
    func prettyPrint() -> String {
        return "Not defined"
    }
}
