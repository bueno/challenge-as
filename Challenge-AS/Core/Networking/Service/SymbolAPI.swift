//
//  SymbolAPI.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/25/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class SymbolAPI {
    
    public static let sharedInstance = SymbolAPI()
    
    private init() {}
    
    func getAllSymbols() -> [Symbol] {
        return SymbolResponse.init().result!
    }
}
