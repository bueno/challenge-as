//
//  Connectivity.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/31/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
