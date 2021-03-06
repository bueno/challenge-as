//
//  ASError.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class ASError: Error {
    
    let errorCode: Int
    let errorMessage: String
    
    init(errorCode: Int, errorMessage: String) {
        
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}
