//
//  Utils.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/31/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class Utils {
    
    static func formatterStringDate(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
    }
    
    static func getTimeFromDate(text: String) -> String {
        let indexStartOfText = text.index(text.startIndex, offsetBy: 11)
        let indexEndOfText = text.index(text.endIndex, offsetBy: -3)
        return String(text[indexStartOfText..<indexEndOfText])
    }
    
    static func getDateFromDate(text: String) -> String {
        let indexStartOfText = text.index(text.startIndex, offsetBy: 0)
        let indexEndOfText = text.index(text.endIndex, offsetBy: -9)
        return String(text[indexStartOfText..<indexEndOfText])
    }
    
}
