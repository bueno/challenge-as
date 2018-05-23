//
//  AbstractRequest.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

// A default 'abstract' class to any Request class
class AbstractRequest {
    
    var page : Int = 1
    var pageSize : Int = 20

    // The end point to make the request
    func urlPath() -> String {
        return ""
    }
    
    // Converts all variables to a dictionary
    func toDictionary() -> [String: Any] {
        return [:]
    }
    
    // Converts all variables to a readable string for debug
    func prettyPrint() -> String {
        return "Not defined"
    }
}
