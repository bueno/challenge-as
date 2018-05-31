//
//  Constants.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation

struct Constants {
    struct AlphaVantage {
        struct Functions {
            static let timeSeriesDaily = "TIME_SERIES_DAILY"
            static let timeSeriesWeekly = "TIME_SERIES_WEEKLY"
            static let timeSeriesMonthly = "TIME_SERIES_MONTHLY"
        }
    }
    
    struct AVENUE {
        static let Name = "Avenue"
        static let Fullname = "Avenue Securities"
    }
    
    struct ALERT {
        static let OOPS = "OOPS".localized
        static let OK = "OK".localized
    }
    
    struct MESSAGE {
        static let INTERNET_CONNECTION_IS_NOT_AVAILABLE = "INTERNET_CONNECTION_IS_NOT_AVAILABLE".localized
        static let AN_UNEXPECTED_ERROR =
        "AN_UNEXPECTED_ERROR".localized
        static let NO_CHART_DATA_AVAILABLE = "NO_CHART_DATA_AVAILABLE".localized
    }
    
    struct LABEL {
        static let CLOSE = "CLOSE".localized
    }
}
