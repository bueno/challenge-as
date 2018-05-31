//
//  Utils.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/31/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

class Utils {

    static func convertStringToDate(date: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)!
    }
}
