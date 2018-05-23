//
//  Constants.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class Constants
{
    public private(set) static var shared = Constants()
    
    public static func reloadLanguage() {
        shared = Constants()
    }
    
    let AVENUE = "Avenue"
    let AVENUE_Securities = "Avenue Securities"
}
